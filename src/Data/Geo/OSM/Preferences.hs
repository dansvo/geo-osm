{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

-- | The @preferences@ element of a OSM file.
module Data.Geo.OSM.Preferences
(
  Preferences
, preferences
) where

import Text.XML.HXT.Arrow.Pickle
import Data.Geo.OSM.Tag
import Data.Geo.OSM.Lens.TagsL
import Control.Lens.Lens
import Control.Newtype

-- | The @preferences@ element of a OSM file.
newtype Preferences =
  Preferences [Tag]
  deriving Eq

-- | Constructs a @preferences@ with tags.
preferences ::
  [Tag] -- ^ The list of tags (@tag@ elements).
  -> Preferences
preferences =
  Preferences

instance XmlPickler Preferences where
  xpickle =
    xpElem "preferences" (xpWrap (preferences, \(Preferences r) -> r) (xpList xpickle))

instance Show Preferences where
  show =
    showPickled []

instance TagsL Preferences where
  tagsL =
    lens unpack (const pack)

instance Newtype Preferences [Tag] where
  pack =
    Preferences
  unpack (Preferences x) =
    x
