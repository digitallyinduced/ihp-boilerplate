module Web.Types where
import Application.Validation

import           ClassyPrelude
import           Web.Controller.Context
import qualified TurboHaskell.Controller.Session
import qualified TurboHaskell.ControllerSupport as ControllerSupport
import           TurboHaskell.HaskellSupport
import           TurboHaskell.ModelSupport
import           Application.Helper.Controller
import qualified Network.Wai
import TurboHaskell.ViewSupport
import Generated.Types
import Data.Dynamic
import Data.Data

data WebApplication = WebApplication deriving (Eq, Show, Generic)

data ViewContext = ViewContext
    { requestContext :: ControllerSupport.RequestContext
    , flashMessages :: [TurboHaskell.Controller.Session.FlashMessage]
    , validations :: [Dynamic]
    , layout :: Layout
    } deriving (Generic)
