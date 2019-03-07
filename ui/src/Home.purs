module Home where

import Prelude

import Data.Maybe (Maybe(..))

import Halogen as H
import Halogen.HTML as HH

import Utils (css)

foreign import unsafeInitialStateHandler :: forall a b. String -> (b -> a) -> b -> a
foreign import unsafeRenderStateHandler :: forall a b. String -> (a -> b) -> a -> b

type State = {}

data Query a
    = NoOp a

component :: forall m. H.Component HH.HTML Query Unit Void m
component =
    H.component
        { initialState: const initialState
        , render: render
        , eval
        , receiver: const Nothing
        }

    where

    initialState :: State
    initialState = {}

    render :: State -> H.ComponentHTML Query
    render state =
        HH.div
            [css "container"]
            [HH.nav
                []
                [ HH.text "Header Component test" ]]

    eval :: Query ~> H.ComponentDSL State Query Void m
    eval = case _ of
        NoOp next -> do
            pure next

        