module Main where
import ClassyPrelude

import Config
import qualified TurboHaskell.Server
import TurboHaskell.RouterSupport
import Web.App
import Web.Types
import TurboHaskell.FrameworkConfig

instance HasPath RootApplication where
    pathTo _ = ""
instance CanRoute RootApplication () where
    parseRoute = parseRoute @WebApplication

main :: IO ()
main = TurboHaskell.Server.run
