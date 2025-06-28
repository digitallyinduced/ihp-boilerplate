module App (start) where

import Control.Monad (void)
import Control.Monad.Trans.Maybe (MaybeT (MaybeT, runMaybeT))
import JSDOM (currentDocument)
import JSDOM.Generated.Node (removeChild)
import JSDOM.Generated.NonElementParentNode (getElementById)
import JSDOM.Generated.ParentNode (getFirstElementChild)
import Miso hiding (getElementById)
import Miso.String (MisoString)

start :: JSM ()
start = do
    maybe (consoleLog "placeholder node not found") (void . uncurry removeChild) =<< runMaybeT do
        doc <- MaybeT currentDocument
        parent <- MaybeT $ getElementById doc ("miso" :: MisoString)
        child <- MaybeT $ getFirstElementChild parent
        pure (parent, child)
    startApp app

app :: App Model Action
app = App
    { model = Model{}
    , update = updateModel
    , view = viewModel
    , events = defaultEvents
    , subs = []
    , initialAction = NoOp
    , mountPoint = Just "miso"
    , logLevel = Off
    }

data Model = Model
    {
    }
    deriving (Eq, Ord, Show)

data Action
    = NoOp
    deriving (Eq, Ord, Show)

updateModel :: Action -> Model -> Effect Action Model
updateModel = fromTransition . \case
    NoOp -> pure ()

viewModel :: Model -> View Action
viewModel _model =
    h2_ [] [text "Miso is working!"]
