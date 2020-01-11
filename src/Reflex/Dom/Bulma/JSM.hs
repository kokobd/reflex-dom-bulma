{-# LANGUAGE CPP #-}

module Reflex.Dom.Bulma.JSM
  ( runJsm
  , JsmConfig(..)
  , loadAndWaitScripts
  ) where

#ifdef ghcjs_HOST_OS
import           Reflex.Dom.Bulma.JSM.GHCJS     (runJsm)
#else
import           Reflex.Dom.Bulma.JSM.Warp      (runJsm)
#endif
import           Reflex.Dom.Bulma.JSM.Types

import           Control.Concurrent          (threadDelay)
import           Control.Lens
import           Control.Monad.IO.Class
import           Data.Foldable               (for_)
import           Data.Functor                (void)
import           Data.Text                   (Text)
import           JSDOM                       (currentDocumentUnchecked)
import           JSDOM.Document              (createElement)
import           Language.Javascript.JSaddle (JSM, ghcjsPure, isUndefined, js,
                                              js1, jsg, jss)

loadAndWaitScripts :: [(Text, Text)] -- ^script url, variable to wait
                   -> JSM ()
loadAndWaitScripts scripts = do
    doc <- currentDocumentUnchecked
    for_ (fmap fst scripts) $ \url -> do
      e <- createElement doc ("script" :: String)
      e ^. jss ("src" :: String) url
      void $ doc ^. (js ("head" :: Text) . js1 ("appendChild" :: Text) e)
    for_ (fmap snd scripts) $ \var ->
      retryAction $ do
        v <- jsg var
        notExists <- ghcjsPure $ isUndefined v
        pure $ if notExists then Nothing else Just ()

retryAction :: JSM (Maybe a) -> JSM a
retryAction m = do
    a <- m
    case a of
      Just e -> pure e
      Nothing -> do
        liftIO $ threadDelay (500 * 1000)
        retryAction m
