module Halogen.VDom.StringRenderer.Util
  ( attrEscape
  , escape
  ) where

import Prelude
import Data.String.Regex (Regex, replace')
import Data.String.Regex.Flags (global)
import Data.String.Regex.Unsafe (unsafeRegex)

escapeRegex ∷ Regex
escapeRegex = unsafeRegex "[\\\"\\\'/&<>]" global

attrEscapeRegex :: Regex
attrEscapeRegex = unsafeRegex "[\\\"\\\'<>]" global

escapeChar ∷ String → String
escapeChar = case _ of
  "\"" → "&quot;"
  "'" → "&#39;"
  "/" → "&#x2F;"
  "&" → "&amp;"
  "<" → "&lt;"
  ">" → "&gt;"
  ch → ch

escape ∷ String → String
escape = replace' escapeRegex (const <<< escapeChar)

attrEscape :: String → String
attrEscape = replace' attrEscapeRegex (const <<< escapeChar)
