module Home where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)

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
            [ nav
            , hero 
            ]

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
                [ HH.text "Hi, I'm Yannick Sealy and I'm a developer based in London"  ] 
            , HH.h2
                [ cs "" ]
                [ HH.text "This is my cv"]
            ]
        ]

type NavItemHref = String
type NavItemName = String

data NavItem = 
    NavItem NavItemHref NavItemName


nav :: forall t1 t2. HH.HTML t2 t1
nav =
    let 
        navData =
            [ NavItem "/#work" "Work"
            , NavItem "/#skills" "Skills"
            , NavItem "/#contact" "Contact" ]

        navItemLi (NavItem href name) =
            HH.li
                    [ cs "nav__item" ]
                    [ HH.a
                        [ HP.href href ]
                        [ HH.text name
                        ]
                    ]

        navList =
            map navItemLi navData
    in
    HH.nav 
        [ cs "nav" ]
        [ HH.div
            [cs "container container--center-vertical" ]
            [ HH.div
                [ cs "nav__brand" ]
                [  HH.a
                    [ HP.href "/" ]
                    [ HH.img
                        [ HP.src "/self.jpg" ]
                    ]
                ]
            , HH.ul
                [ cs "nav__items" ]
                navList
            ]
        ]