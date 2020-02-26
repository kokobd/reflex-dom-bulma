module Reflex.Dom.Bulma.Component.Button
  ( linkButton
  , linkButtonDynAttr
  , linkButtonDynAttr_
  , buttonAttr
  , buttonDynAttr
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

linkButtonDynAttr :: MonadWidget t m
                  => Dynamic t (Map Text Text)
                  -> m a
                  -> m (Event t (), a)
linkButtonDynAttr attrDyn child = do
    (e, a) <- elDynAttr' "a" attrDyn child
    pure (domEvent Click e, a)

linkButtonDynAttr_ :: MonadWidget t m
                   => Dynamic t (Map Text Text)
                   -> m a
                   -> m (Event t ())
linkButtonDynAttr_ attrDyn child = do
    (e, a) <- linkButtonDynAttr attrDyn child
    pure e

buttonAttr :: MonadWidget t m
           => Map Text Text
           -> m a
           -> m (Event t (), a)
buttonAttr attr child = do
    (e, a) <- elAttr' "button" attr child
    pure (domEvent Click e, a)

buttonDynAttr :: MonadWidget t m
              => Dynamic t (Map Text Text)
              -> m a
              -> m (Event t (), a)
buttonDynAttr attrDyn child = do
    (e, a) <- elDynAttr' "button" attrDyn child
    pure (domEvent Click e, a)
