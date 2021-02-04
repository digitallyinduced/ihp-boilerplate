module Main where

import Prelude
import Control.Monad.Error.Class (throwError)
import Data.Const (Const)
import Data.Maybe (maybe)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Halogen as H
import Halogen.Aff (runHalogenAff, selectElement)
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)
import Web.DOM.ParentNode (QuerySelector(..))
import Web.HTML (HTMLElement)

component :: forall m. H.Component HH.HTML (Const Void) Unit Void m
component =
  H.mkComponent
    { initialState: const unit
    , eval: H.mkEval H.defaultEval
    , render: const $ HH.div_ [ HH.h1_ [ HH.text "PureScript + Halogen is also working!" ] ]
    }

main :: Effect Unit
main =
  runHalogenAff do
    rootElement <- selectElement' "PureScript Halogen could not find element '#halogen'" $ QuerySelector "#halogen"
    (runUI component unit) rootElement

selectElement' :: String -> QuerySelector -> Aff HTMLElement
selectElement' errorMessage query = do
  maybeElem <- selectElement query
  maybe (throwError (error errorMessage)) pure maybeElem
