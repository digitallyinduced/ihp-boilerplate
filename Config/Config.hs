module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig

instance FrameworkConfig where 
    environment = Development
    baseUrl = "http://localhost:8000"
