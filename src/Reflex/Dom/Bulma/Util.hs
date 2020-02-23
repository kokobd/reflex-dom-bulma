module Reflex.Dom.Bulma.Util
  ( parseFormDateTime
  , renderFormDateTime
  ) where

import           Data.Text (Text)
import qualified Data.Text as T
import           Data.Time

parseFormDateTime :: Text -> LocalTime
parseFormDateTime t = parseTimeOrError True defaultTimeLocale formDateTimeFormatStr (T.unpack t)

renderFormDateTime :: LocalTime -> Text
renderFormDateTime = T.pack . formatTime defaultTimeLocale formDateTimeFormatStr

formDateTimeFormatStr :: String
formDateTimeFormatStr = "%Y-%m-%dT%H:%M"
