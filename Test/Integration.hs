module Main where

import Test.Hspec
import IHP.Prelude
import IHP.ModelSupport
import IHP.Log.Types
import System.Environment (lookupEnv)

-- Integration tests run with a temporary PostgreSQL database.
-- The DATABASE_URL env var is set automatically by `nix flake check`.
-- See: https://ihp.digitallyinduced.com/Guide/testing.html
main :: IO ()
main = do
    databaseUrl <- lookupEnv "DATABASE_URL" >>= \case
        Just url -> pure (cs url)
        Nothing -> error "DATABASE_URL not set. Run `devenv up` first or use `nix flake check`."
    logger <- newLogger def { level = Warn }
    withModelContext databaseUrl logger \modelContext -> do
        let ?modelContext = modelContext
        hspec do
            describe "Database" do
                it "can execute a query" do
                    sqlExecDiscardResult "SELECT 1" ()
