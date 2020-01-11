module Reflex.Dom.Bulma.Component.LinkButton
  ( linkButton
  ) where

import           Data.Map.Strict (Map)
import           Data.Text       (Text)
import           Reflex.Dom

linkButton :: MonadWidget t m
           => Map Text Text
           -> m a
           -> m (Event t (), a)
linkButton attr child = do
    (e, a) <- elAttr' "a" attr child
    pure (domEvent Click e, a)
