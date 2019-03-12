module Components.Footer where

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)


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
                        [ HP.href "https://github.com/Hairlock", cs "footer-links__item-link", HP.target "_blank" ]
                        [ HH.text "Github"
                        ]
                    ]
                , HH.li
                    [ cs "footer-links__item" ]
                    [ HH.a
                        [ HP.href "https://www.linkedin.com/in/yannick-sealy-b7585970", cs "footer-links__item-link", HP.target "_blank" ]
                        [ HH.text "LinkedIn"
                        ]
                    ]
                , HH.li
                    [ cs "footer-links__item" ]
                    [ HH.a
                        [ HP.href "mailto: yannseal1@gmail.com", cs "footer-links__item-link", HP.target "_blank" ]
                        [ HH.text "Email"
                        ]
                    ]
                ] 
            ]
        ]