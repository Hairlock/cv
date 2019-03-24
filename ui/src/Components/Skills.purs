module Components.Skills where

import Prelude


import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Utils.Html (cs)


skills :: forall t1 t2. HH.HTML t2 t1
skills =
    let 
        allSkills =
            [ { title: "Know Pretty Well", pills: ["Elm", "React", "C#", "JS"
                , "CI/CD", "Docker", "Nginx", "SQL", "Git", "Build-tools"] }
            , { title: "Bit Rusty", pills:  ["K8s", "Clojure/Cljs", "AWS"] }
            , { title: "Very Keen On", pills: ["Haskell", "Purescript", "Coding :)"] }
            ] 

        skillContainer {title, pills} =
            HH.div
                [ cs "wrapper" ]
                [ HH.h3
                    [ cs "header" ]
                    [ HH.text title]
                , HH.ul
                    [ cs "pills" ]
                    (map 
                        (\name -> HH.li
                                    [ cs "skill" ]
                                    [ HH.text name
                                    ])
                    pills)
                ]
    in
    HH.section_
        [ HH.div
            [ cs "skills", HP.id_ "skills" ]
            [ HH.div [ cs "title-wrapper"]
                [HH.h2
                    [ cs "title" ]
                    [ HH.text "Skill Breakdown"
                    ]
                ]
            , HH.div 
                [ cs "container separated"]
                (map skillContainer allSkills)
            ]
        ]
        