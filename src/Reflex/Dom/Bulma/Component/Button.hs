module Reflex.Dom.Bulma.Component.Button
  ( linkButton
  , button
  ) where

import           Data.Map.Strict (Map)
import           Data.Text       (Text)
import           Reflex.Dom      hiding (button)

linkButton :: MonadWidget t m
           => Map Text Text
           -> m a
           -> m (Event t (), a)
linkButton attr child = do
    (e, a) <- elAttr' "a" attr child
    pure (domEvent Click e, a)

button :: MonadWidget t m
       => Map Text Text
       -> m a
       -> m (Event t (), a)
button attr child = do
    (e, a) <- elAttr' "button" attr child
    pure (domEvent Click e, a)
