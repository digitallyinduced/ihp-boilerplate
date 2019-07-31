module Main where
import ClassyPrelude

import Config
import qualified TurboHaskell.Server
import TurboHaskell.RouterSupport
import TurboHaskell.FrameworkConfig

instance FrontController RootApplication where
    prefix = ""
    controllers =
        [
        ]

main :: IO ()
main = TurboHaskell.Server.run
