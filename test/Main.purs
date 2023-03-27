module Test.Main where

import Prelude
import Effect (Effect)
import Test.Halogen.VDom.DOM.StringRenderer as StringRenderer

main :: Effect Unit
main = StringRenderer.tests
