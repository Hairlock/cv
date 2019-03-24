module Components.Nav where

import Prelude

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

        navList =
            map (NavItem >>> navItemLi) navItems
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
                        [ HP.src "/face.jpg" ]
                    ]
                ]
            , HH.ul
                [ cs "nav__items" ]
                navList
            ]
        ]