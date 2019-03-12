module Components.Background where

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)

background :: forall t1 t2. HH.HTML t2 t1
background =
    let 
        summaryListItemLi text =
            HH.li
                [ cs "summary-list__item" ]
                [ HH.text text
                ]
    in
    HH.section_
        [ HH.div
            [ cs "background", HP.id_ "background" ]
            [ HH.div
                [ cs "container" ]
                [ HH.div
                    [ cs "background-summary" ]
                    [ HH.p
                        [ cs "title" ]
                        [ HH.text "A bit about me"
                        ]
                    , HH.p
                        [ cs "summary" ]
                        [ HH.text "This is the place where I speak a bit\
                        \ about myself and all the things I used to do and would\
                        \ like to do now, etc. Interests and hobbies, brazilian jiu jitsu,\
                        \ climbing, programming and stuff and things, can maybe also talk\
                        \ about side projects like the crypto thing"
                        ]
                    , HH.ul
                        [ cs "summary-list" ]
                        [ summaryListItemLi "Elm is my language that I use at work\
                        \ and also used as the frontend for a Cryptocurrency website"
                        , summaryListItemLi "Haskell and purescript are also quite fascinating\
                        \ to me and I have begun to use them as well, this site is written in purescript\
                        \ with a haskell backend"
                        , summaryListItemLi "Clojure is also a fantastic language which I have\
                        \ used successful in a work production environment"
                        ]
                    ]
                ]
            ]
        ]