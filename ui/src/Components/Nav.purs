module Components.Nav where

import Prelude

import Data.Array (concat)
import Halogen.HTML as HH

import Halogen.HTML.Properties as HP
import Utils.Html (cs)

data NavItem = NavItem
    { href :: String
    , name ::  String
    }


nav :: forall t1 t2. HH.HTML t2 t1
nav =
    let 
        navItems =
            [ { href : "/#background", name : "Background"}
            , { href : "/#experience", name : "Experience"}
            , { href : "/#skills", name : "Skills"}
            , { href : "/#contact", name : "Contact"}
            ]

        navItemLi (NavItem {href, name}) =
            HH.li
                [ cs "nav__item" ]
                [ HH.a
                    [ HP.href href ]
                    [ HH.text name
                    ]
                ]
        
        cv =
            HH.li
                [ cs "nav__item" ]
                [ HH.a
                    [ HP.href "/Yannick_Sealy_CV.pdf"
                    , HP.target "_blank"
                    , HP.attr (HH.AttrName "download") "Yannick_Sealy_CV"]
                    [ HH.text "CV"
                    ]
                ]
        

        navList =
            concat $ [ map (NavItem >>> navItemLi) navItems, [cv]]        
    in
    HH.nav 
        [ cs "nav", HP.id_ "nav" ]
        [ HH.div
            [cs "container" ]
            [ HH.div
                [ cs "nav__brand" ]
                [  HH.a
                    [ HP.href "/" ]
                    [ HH.img
                        [ HP.src "/face.png" ]
                    ]
                ]
            , HH.ul
                [ cs "nav__items" ]
                navList
            ]
        ]