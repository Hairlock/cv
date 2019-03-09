module Home where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Utils.Css (cs)

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
            [cs "main"]
            [ hero ]

    eval :: Query ~> H.ComponentDSL State Query Void m
    eval = case _ of
        NoOp next -> do
            pure next

        
hero :: forall t1 t2. HH.HTML t2 t1
hero =
    HH.section 
        [ cs "hero" ]
        [ HH.div 
            [ cs "container" ]
            [ HH.h1 
                [ cs "hero__title"]
                [ HH.text "Hey, I'm Yannick and I'm a developer based \
                \in London."  ] 
            ]
        ]