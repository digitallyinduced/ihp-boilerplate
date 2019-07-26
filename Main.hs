module Main where
import ClassyPrelude

import Config
import qualified TurboHaskell.Server
import TurboHaskell.RouterSupport
import TurboHaskell.FrameworkConfig

import Web.Types
import Web.FrontController

instance FrontController RootApplication where
    prefix = ""
    controllers =
        [ mountFrontController @WebApplication
        ]

main :: IO ()
main = TurboHaskell.Server.run
