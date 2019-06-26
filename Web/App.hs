module Web.App where
import TurboHaskell.RouterPrelude
import Generated.Types
import Web.Types

-- Controller Imports
import TurboHaskell.Welcome.Controller

instance HasPath WebApplication where
    pathTo WebApplication = ""

instance CanRoute WebApplication () where
    parseRoute = withPrefix "/"
                [ parseRoute @WelcomeController
                -- Generator Marker
                ]

