module Utils.Html where

import Prelude
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

cs :: forall r i. String -> HH.IProp ( class :: String | r ) i
cs = HP.class_ <<< HH.ClassName