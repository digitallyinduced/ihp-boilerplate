module Main where
import IHP.Prelude

import Config
import qualified IHP.Server
import IHP.RouterSupport
import IHP.FrameworkConfig
import IHP.Job.Types

instance FrontController RootApplication where
    controllers = []

instance Worker RootApplication where
    workers _ = []

main :: IO ()
main = IHP.Server.run config
