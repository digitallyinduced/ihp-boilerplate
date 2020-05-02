module Config where

import TurboHaskell.Prelude
import TurboHaskell.Environment
import TurboHaskell.FrameworkConfig

instance FrameworkConfig where 
    environment = Development
    baseUrl = "http://localhost:8000"
