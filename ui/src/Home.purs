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
            , history
            , footer
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

data NavItem = NavItem
    { href :: String
    , name ::  String
    }


nav :: forall t1 t2. HH.HTML t2 t1
nav =
    let 
        navItems =
            [ { href : "/#history", name : "History"}
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
        [ cs "nav" ]
        [ HH.div
            [cs "container" ]
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

data HistoryItem = HistoryItem 
    { parent :: String
    , subtitle :: String
    , role :: String
    , date :: String
    , href :: String
    }


history :: forall t1 t2. HH.HTML t2 t1
history = 
    HH.section
        [ cs "history-container" ]
        [ HH.div
            [ cs "container" ]
            [ HH.h2
                [ cs "header" ]
                [ HH.text "History"
                ] 
            ]          
        , HH.ul
            [ cs "history__items" ]
            (map (HistoryItem >>> historyItemLi) historyItems)
        ]
    where
        historyItems =
            [ { parent: "Dnata Travel", subtitle: "Emirates Holidays B2B", role: "Full Stack Developer", date: "2018", href: "https://www.emiratesholidays.com"}
            , { parent: "Dnata Travel", subtitle: "Travel Republic B2C", role: "Frontend Developer", date: "2016", href: "https://www.travelrepublic.co.uk"}
            , { parent: "UCL", subtitle: "Computer Science", role: "Microsoft Sponsored Project", date: "2013", href: "https://www.ucl.ac.uk/prospective-students/graduate/taught-degrees/computer-science-msc"}
            , { parent: "Imperial", subtitle: "Biomedical Engineering", role: "In-Uni Project", date: "2009", href: "https://www.ucl.ac.uk/prospective-students/graduate/taught-degrees/computer-science-msc"}
            ]

        historyItemLi (HistoryItem {parent, subtitle, role, date, href}) =
            HH.li
                [ cs "history__item" ]
                [ HH.a
                    [ HP.target "_blank"
                    , cs "history__item-link"
                    , HP.href href ]
                    [ HH.h2
                        [ cs "history-parent" ]
                        [ HH.text parent
                        ]
                    , HH.span
                        [ cs "history-detail history-subtitle" ]
                        [ HH.text subtitle
                        ]
                    , HH.span
                        [ cs "history-detail history-role" ]
                        [ HH.text role
                        ]
                    , HH.span
                        [ cs "history-detail history-date" ]
                        [ HH.text date
                        ]
                    ]
                ]


footer :: forall t1 t2. HH.HTML t2 t1
footer = 
    HH.footer
        [ cs "footer", HP.id_ "contact" ]
        [ HH.div
            [ cs "container" ]
            [ HH.h2
                [ cs "footer-hero" ]
                [ HH.text "Looking to get in touch? Find me"
                , HH.a
                    [ cs "hero__link", HP.href "mailto: yannseal1@gmail.com" ]
                    [ HH.text "here"
                    ]
                ]
            ]
        , HH.div
            [ cs "container" ]
            [ HH.ul
                [ cs "footer-links" ]
                [ HH.li
                    [ cs "footer-links__item" ]
                    [ HH.a
                        [ HP.href "https://github.com/Hairlock", cs "footer-links__item-link" ]
                        [ HH.text "Github"
                        ]
                    ]
                , HH.li
                    [ cs "footer-links__item" ]
                    [ HH.a
                        [ HP.href "https://www.linkedin.com/in/yannick-sealy-b7585970", cs "footer-links__item-link" ]
                        [ HH.text "LinkedIn"
                        ]
                    ]
                , HH.li
                    [ cs "footer-links__item" ]
                    [ HH.a
                        [ HP.href "mailto: yannseal1@gmail.com", cs "footer-links__item-link" ]
                        [ HH.text "Email"
                        ]
                    ]
                ] 
            ]
        ]