module Prelude
  ( module Control.Arrow.Unicode
  , module Control.Exception.Safe
  , module Control.Monad.Except
  , module Control.Monad.Unicode
  , module Data.Bool.Unicode
  , module Data.Eq.Unicode
  , module Data.List.Unicode
  , module Data.Monoid.Unicode
  , module Data.Ord.Unicode
  , module Relude
  , applyWhen
  , echo
  , justIf
  , positJust
  , pp
  ) where

import Control.Arrow.Unicode
import Control.Exception.Safe (MonadCatch, MonadThrow, catchAny)
import Control.Monad.Except
import Control.Monad.Unicode
import Data.Bool.Unicode
import Data.Char              qualified as Char
import Data.Eq.Unicode
import Data.Generics.Labels   ()
import Data.List.Unicode
import Data.Monoid.Unicode
import Data.Ord.Unicode
import Relude

----------------------------------------------------------------------------------------------------

-- | Short name for putTextLn
echo ∷ MonadIO m ⇒ Text → m ()
echo = putTextLn

-- | Useful to stringify data constructors
pp ∷ Show a ⇒ a → String
pp = pascalToTitleCase . show where
  pascalToTitleCase ""     = ""
  pascalToTitleCase (c:cs) = c:loop cs where
    loop "" = ""
    loop (x:xs) | Char.isUpper x = ' ':x:loop xs
                | otherwise      = x:loop xs

applyWhen ∷ Bool → (a → a) → a → a
applyWhen cond f a = if cond then f a else a

justIf ∷ Bool → a → Maybe a
justIf cond a = if cond then Just a else Nothing

positJust ∷ MonadError e m ⇒ e → Maybe a → m a
positJust _err (Just a) = pure a
positJust err  Nothing  = throwError err
