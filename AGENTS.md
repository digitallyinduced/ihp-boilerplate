# Hoogle

When you need to find functions, look up type signatures, discover data structures, or read documentation for any Haskell package used in this project, use Hoogle. It indexes all packages from `flake.nix`, so it's the primary way to explore available APIs and read Hackage-style documentation without leaving the dev environment.

```bash
hoogle search "Text -> ByteString"   # Search by type signature, function name, or data type
# Hoogle web UI at http://localhost:8002 - browse and read full Hackage docs for all project packages
```

# SQL

Use `sqlQueryTyped [typedSql| ... |]` / `sqlExecTyped [typedSql| ... |]` for application SQL. Raw `sqlQuery` is disallowed for normal app queries because it bypasses Postgres type inference and can hide decoder mismatches like `count(*)` returning `int8`. Only use raw/unsafe SQL for narrow cases where typed SQL cannot work, and leave a comment explaining why.

# Tests

Run the full project test suite with:

```bash
nix flake check --impure
```

Use this command as the canonical verification step before handing off changes that affect application behavior, SQL, generated code, Nix configuration, dependencies, or CI. For fast local iteration, focused GHCi checks are fine, but `nix flake check --impure` is the full project check.
