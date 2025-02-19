module App (start) where

import Miso

start :: JSM ()
start = startApp app

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
