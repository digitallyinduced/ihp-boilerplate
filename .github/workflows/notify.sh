#!/bin/bash

set -e

API_URL="https://api.github.com"

extract_issue_number() {
    local commit_message="$1"
    local issue_number
    local pr_number

    # Try to extract from "Merge pull request ... from branch/123"
    issue_number=$(echo "$commit_message" | grep -oP 'from [a-zA-Z-_0-9]+/\K([0-9]+)')

    if [ -z "$issue_number" ]; then
        # Try to extract from "... (#123)"
        pr_number=$(echo "$commit_message" | grep -oP '\(#\K([0-9]+)(?=\))')

        if [ -n "$pr_number" ]; then
            # Fetch PR description
            pr_description=$(curl -s -H "Authorization: token $GH_TOKEN" "$API_URL/repos/$GITHUB_REPOSITORY/pulls/$pr_number" | jq -r .body)

            if [ -n "$pr_description" ]; then
                # Extract issue numbers from PR description
                issue_numbers=($(echo "$pr_description" | grep -oP '#\K([0-9]+)(?=\s)'))

                if [ ${#issue_numbers[@]} -gt 0 ]; then
                    issue_number=${issue_numbers[0]}
                fi
            fi
        fi
    fi

    echo "$issue_number $pr_number"
}

print_debug_info() {
    echo "Debug Information:"
    echo "COMMIT_MESSAGE: $COMMIT_MESSAGE"
    echo "ISSUE_NUMBER: $ISSUE_NUMBER"
    echo "PR_NUMBER: $PR_NUMBER"
    echo "GITHUB_REPOSITORY: $GITHUB_REPOSITORY"
    echo "URL_QA: $URL_QA"
    echo "API_URL: $API_URL"
    echo "Environment Variables:"
    env
}

COMMIT_MESSAGE=$(git log -1 --pretty=format:"%s")

# Extract the issue number and PR number
read ISSUE_NUMBER PR_NUMBER <<< $(extract_issue_number "$COMMIT_MESSAGE")

if [ -z "$ISSUE_NUMBER" ]; then
    echo "Could not determine the issue number from the commit message."
    exit 0
fi

if [ -n "$PR_NUMBER" ]; then
    COMMENT_BODY="The latest changes (#$PR_NUMBER) have been deployed successfully to [$URL_QA]($URL_QA)"
else
    COMMENT_BODY="The latest changes have been deployed successfully to [$URL_QA]($URL_QA)"
fi

# Make the API call and capture both the HTTP status code and the response body
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
     -H "Authorization: token $GH_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     "$API_URL/repos/$GITHUB_REPOSITORY/issues/$ISSUE_NUMBER/comments" \
     -d "{\"body\":\"$COMMENT_BODY\"}")

# Extract the response body and status code
RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')
STATUS_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$STATUS_CODE" -ne 201 ]; then
    echo "Failed to post comment to issue #$ISSUE_NUMBER. HTTP status code: $STATUS_CODE"
    echo "Response body:"
    echo "$RESPONSE_BODY"
    print_debug_info
    exit 1
fi

echo "Comment posted to issue #$ISSUE_NUMBER"
