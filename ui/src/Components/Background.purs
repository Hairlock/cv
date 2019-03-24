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
            [ HH.div [ cs "title-wrapper"]
                [HH.h2
                    [ cs "title" ]
                    [ HH.text "A bit about me"
                    -- , HH.text " )"
                    ]
                , HH.a [cs "tldr", HP.href "#tldr"]
                [
                HH.h2
                    [ cs "title" ]
                    [ HH.text "TL;DR;"
                    , HH.span [cs "icon far fa-hand-point-down"] []
                    ]
                ]
                ]
            , HH.div
                [ cs "container" ]
                [ HH.div
                    [ cs "background-summary" ]
                    [ HH.p
                        [ cs "summary" ]
                        [ HH.text "My origin story is pretty standard, I went to uni to do something \
                        \and ended up switching to something (not so) different. Science and \
                        \engineering have always fascinated me and when I realized the amazing things that could be done in the field of computer science I was hooked."
                        ]
                    , HH.p
                        [ cs "summary" ]
                        [ HH.text "I was lucky enough to work under a person who firmly believed in solving problems correctly and \
                            \seeking out the best solution, not just the most expedient one. The influence of this mindset was \
                            \evident for all to see and the team around him flourished. We created resilient and functional \
                            \tools and programs and weren't afraid to think outside the box to come up with creative solutions."
                        ]
                    , HH.p
                        [ cs "summary" ]
                        [ HH.text "The majority of my work time is spent on a production Elm application (>50k LOC). I do various other \
                            \tasks in the API and Database layer that support this app. Devops is a big interest of mine as well \
                            \and I work on deployment pipelines for various apps with Docker and Kubernetes. My work has always \
                            \been pretty language agnostic. My work environment is such that if you chose to, you could create \
                            \encapsulated modules written in different languages, I used this opportunity to explore Clojure/Cljs, \
                            \ReactJS and more."
                        ]
                    , HH.p
                        [ cs "summary" ]
                        [ HH.text "My goals right now are to put myself on a path to doing something challenging and fulfilling. I \
                            \would like the opportunity to learn and improve on a wide variety of my skills in a cross-functional \
                            \environment. I am self motivated and learn well on my own but there's an undeniable quality to getting \
                            \your ideas and assumptions tested in real world scenarios. Working with others towards a common goal \
                            \is a magnificient way to grow in skill and experience. "
                        ]
                    , HH.p
                        [ cs "summary" ]
                        [ HH.text "What I'm currently seeking is to immerse myself in the deep end with Haskell. The expressive \
                            \power of the type system and the extensibility of the language appealed to me from the start. It's been a \
                            \few iterations of diving into this language and I feel ready to take on the challenge of gaining proficiency."]
                    , HH.p
                        [cs "summary tldr",  HP.id_ "tldr" ]
                        [ HH.text "TL;DR;"
                        ]
                    , HH.ul
                        [ cs "summary-list" ]
                        [ summaryListItemLi "I like being cross-functional: Frontend, Backend, Db, Devops"
                        , summaryListItemLi "I would like to work on Haskell and Purescript professionally"
                        ]
                    ]
                ]
            ]
        ]