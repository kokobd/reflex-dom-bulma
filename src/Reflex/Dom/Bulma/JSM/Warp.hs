module Reflex.Dom.Bulma.JSM.Warp
  ( runJsm
  ) where

import           Language.Javascript.JSaddle.Run        (syncPoint)
import           Language.Javascript.JSaddle.Types      (JSM)
import           Language.Javascript.JSaddle.WebSockets (jsaddleApp, jsaddleOr)
import           Network.Wai
import           Network.Wai.Application.Static         (defaultWebAppSettings,
                                                         ssMaxAge, staticApp)
import qualified Network.Wai.Handler.Warp               as Warp (run)
import           Network.WebSockets.Connection          (defaultConnectionOptions)
import           WaiAppStatic.Types                     (MaxAge (MaxAgeSeconds))

import           Reflex.Dom.Bulma.JSM.Types

{-| Run JSM as warp application
The app will be served at given port. @/@, @/jsaddle.js@, @/sync/**@ are handled
by jsaddle-warp, while other URLs are handled by a file server with the given
root folder.
-}
runJsm :: JsmConfig
       -> JSM ()
       -> IO ()
runJsm config jsm = do
    jsApp <- jsaddleOr defaultConnectionOptions (jsm >> syncPoint) jsaddleApp
    runApp config jsApp

runApp :: JsmConfig
       -> Application
       -> IO ()
runApp (WarpConfig port dir) app =
    Warp.run port (redirectFrontendRoute dir app)

redirectFrontendRoute :: FilePath -> Application -> Application
redirectFrontendRoute staticDir app request =
    case pathInfo request of
      []             -> app request
      ["jsaddle.js"] -> app request
      ("sync":_)     -> app request
      ("r":_)        -> app request'
      _              -> staticApp' request
  where
    request' = request { pathInfo = pathInfo' }
    pathInfo' =
      case pathInfo request of
        "r":_ -> []
        xs    -> xs
    webAppSettings = (defaultWebAppSettings staticDir)
      { ssMaxAge = MaxAgeSeconds 0
      }
    staticApp' = staticApp webAppSettings
