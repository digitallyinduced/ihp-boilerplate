# Local Haskell Libraries

Put local Cabal packages in this directory when code should live outside the IHP application but stay in the same repository.

Typical structure:

```text
lib/
`-- my-client/
    |-- default.nix
    |-- my-client.cabal
    `-- src/
        `-- MyClient.hs
```

Generate `default.nix` inside the package directory and commit it:

```bash
cd lib/my-client
nix run nixpkgs#cabal2nix -- . > default.nix
```

Then add the package to `haskellPackages` in `flake.nix`:

```nix
haskellPackages = p: with p; [
    p.ihp
    base
    wai
    text
    (p.callPackage ./lib/my-client {})
];
```

IHP ignores this top-level `lib/` directory when scanning application modules, so local libraries are compiled through their own Cabal packages.
