module Components.Experience where

import Prelude

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)

data ExperienceItem = ExperienceItem 
    { parent :: String
    , subtitle :: String
    , role :: String
    , date :: String
    , href :: String
    }


experience :: forall t1 t2. HH.HTML t2 t1
experience = 
    HH.section
        [ cs "experience-container", HP.id_ "experience" ]
        [ HH.div
            [ cs "container" ]
            [ HH.h2
                [ cs "header" ]
                [ HH.text "Experience & Education"
                ] 
            ]          
        , HH.ul
            [ cs "experience__items" ]
            (map (ExperienceItem >>> experienceItemLi) experienceItems)
        ]
    where
        experienceItems =
            [ { parent: "Dnata Travel", subtitle: "Emirates Holidays B2B", role: "Full Stack Developer", date: "2018", href: "https://www.emiratesholidays.com"}
            , { parent: "Dnata Travel", subtitle: "Travel Republic B2C", role: "Frontend Developer", date: "2016", href: "https://www.travelrepublic.co.uk"}
            , { parent: "UCL", subtitle: "Computer Science", role: "Microsoft Sponsored Project", date: "2013", href: "https://www.ucl.ac.uk/prospective-students/graduate/taught-degrees/computer-science-msc"}
            , { parent: "Imperial", subtitle: "Biomedical Engineering", role: "In-Uni Project", date: "2009", href: "https://www.ucl.ac.uk/prospective-students/graduate/taught-degrees/computer-science-msc"}
            ]

        experienceItemLi (ExperienceItem {parent, subtitle, role, date, href}) =
            HH.li
                [ cs "experience__item" ]
                [ HH.a
                    [ HP.target "_blank"
                    , cs "experience__item-link"
                    , HP.href href ]
                    [ HH.h2
                        [ cs "experience-parent" ]
                        [ HH.text parent
                        ]
                    , HH.span
                        [ cs "experience-detail experience-subtitle" ]
                        [ HH.text subtitle
                        ]
                    , HH.span
                        [ cs "experience-detail experience-role" ]
                        [ HH.text role
                        ]
                    , HH.span
                        [ cs "experience-detail experience-date" ]
                        [ HH.text date
                        ]
                    ]
                ]