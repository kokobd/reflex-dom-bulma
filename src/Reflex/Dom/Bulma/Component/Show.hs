module Reflex.Dom.Bulma.Component.Show
  ( showWidget
  , hiddenClass
  ) where

import           Data.Text  (Text)
import           Reflex.Dom

hiddenClass :: Reflex t => Dynamic t Bool -> Dynamic t Text
hiddenClass = fmap (\hidden -> if hidden then " is-hidden" else "")

showWidget :: MonadWidget t m
           => Dynamic t Bool
           -> m a
           -> m a
showWidget showDyn = elDynClass "div" (hiddenClass (fmap not showDyn))
