{-# LANGUAGE CPP #-}

module Reflex.Dom.Bulma.JSM.GHCJS where

-- make hie ignore this module
#ifdef ghcjs_HOST_OS

import           Reflex.Dom.Bulma.Types
import           Language.Javascript.JSaddle.Types (JSM)

runJsm :: JsmConfig -> JSM () -> IO ()
runJsm _ = id

#endif
