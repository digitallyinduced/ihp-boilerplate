module Main exposing (main)

import Browser
import Html exposing (Html, h2, text)


type alias Model =
  {}


type Msg
  = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html msg
view model =
  h2 [] [ text "Elm is working!" ]


main : Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


init : () -> ( Model, Cmd Msg )
init _ =
  ( {}
  , Cmd.none
  )
