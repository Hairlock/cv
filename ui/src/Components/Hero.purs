module Components.Hero where

import Prelude

import Data.Array (concat)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)

data NavItem = NavItem
    { href :: String
    , name ::  String
    }


hero :: forall t1 t2. HH.HTML t2 t1
hero =
    let
        languages =
            [ { logo: "elm_logo.svg", href: "https://elm-lang.org/"}
            , { logo: "haskell_logo.svg", href: "https://www.haskell.org/"}
            , { logo: "purescript_logo.svg", href: "http://www.purescript.org/"}
            ]

        interests =
            [ { logo: "fp_logo.svg", href: "https://www.youtube.com/watch?v=LnX3B9oaKzw"}
            , { logo: "climbing_logo.svg", href: "https://www.archclimbingwall.com/centres"}
            ] 

        interestItem {logo, href} =
            HH.a
                [ HP.href href, HP.target "_blank" ]
                [ HH.img [ HP.src $ "/" <> logo ]
                ]

        interestLabel label =
            [ HH.h3
                [ cs "interest__label" ]
                [ HH.text label
                ]
            ]    

        interestBuilder label items =
            concat $ [ interestLabel label, map interestItem items ]

        languageInterests =
            interestBuilder "Languages:" languages

        otherInterests =
            interestBuilder "Interests:" interests
    in
    HH.section 
        [ cs "hero" ]
        [ HH.div 
            [ cs "container" ]
            [ HH.h1 
                [ cs "hero__title"]
                [ HH.text "Hi, I'm Yannick Sealy, a developer\
                 \ based in London. I'm interested in functional programming \
                 \ among other things :) "  ] 
            ]
        , HH.div
            [ cs "container container--wrap" ]
            [ HH.div
                [ cs "hero__interest" ]
                languageInterests             
            , HH.div
                [ cs "hero__interest" ]
                otherInterests
            ]
        ]