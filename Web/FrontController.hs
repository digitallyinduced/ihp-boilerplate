module Web.FrontController where
import TurboHaskell.RouterPrelude
import Generated.Types
import Web.Types

-- Controller Imports
import TurboHaskell.Welcome.Controller

instance FrontController WebApplication where
    prefix = "/"
    controllers = 
        [ parseRoute @WelcomeController
        -- Generator Marker
        ]

