# Hoogle

When you need to find functions, look up type signatures, discover data structures, or read documentation for any Haskell package used in this project, use Hoogle. It indexes all packages from `flake.nix`, so it's the primary way to explore available APIs and read Hackage-style documentation without leaving the dev environment.

```bash
hoogle search "Text -> ByteString"   # Search by type signature, function name, or data type
# Hoogle web UI at http://localhost:8002 - browse and read full Hackage docs for all project packages
```

# SQL

Use `sqlQueryTyped [typedSql| ... |]` / `sqlExecTyped [typedSql| ... |]` for application SQL. Raw `sqlQuery` is disallowed for normal app queries because it bypasses Postgres type inference and can hide decoder mismatches like `count(*)` returning `int8`. Only use raw/unsafe SQL for narrow cases where typed SQL cannot work, and leave a comment explaining why.

# Migrations

When you create a migration in `Application/Migration/`, set the revision prefix from the **current Unix timestamp** — run `date +%s` and use that exact number, then add a description: `Application/Migration/$(date +%s)-<description>.sql`. **Never hand-pick or round the number** (e.g. taking the latest revision and bumping it to a round value). IHP records only the numeric revision in `schema_migrations`, so if two migrations share a revision — which happens easily when parallel branches both round to the same "nice" number — IHP runs ONE and silently SKIPS the other. The skipped migration's columns/tables never get created while the merged code expects them, so the next deploy fails every affected query with `column … does not exist`. A raw `date +%s` is second-precise and monotonic, so parallel branches always get distinct, correctly-ordered revisions. If a duplicate still slips through, repair it with an idempotent migration at a fresh unique revision that re-applies whichever side was skipped — don't renumber a migration that may already have run somewhere.

# Tests

Run the full project test suite with:

```bash
nix flake check --impure
```

Use this command as the canonical verification step before handing off changes that affect application behavior, SQL, generated code, Nix configuration, dependencies, or CI. For fast local iteration, focused GHCi checks are fine, but `nix flake check --impure` is the full project check.
