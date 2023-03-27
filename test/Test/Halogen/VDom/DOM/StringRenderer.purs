module Test.Halogen.VDom.DOM.StringRenderer
  ( tests
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Halogen.VDom.DOM.Prop (Prop(..), propFromString)
import Halogen.VDom.DOM.StringRenderer as StringRenderer
import Halogen.VDom.Types as VDom
import Test.Assert as Assert

tests :: Effect Unit
tests = do
  testText
  testEscapeText
  testStylesheet
  testScript

testText :: Effect Unit
testText =
  Assert.assertEqual
    { actual: render (VDom.Text "Test text")
    , expected: "Test text"
    }

testEscapeText :: Effect Unit
testEscapeText =
  Assert.assertEqual
    { actual: render (VDom.Text "\"'/&<>")
    , expected: "&quot;&#39;&#x2F;&amp;&lt;&gt;"
    }

testStylesheet :: Effect Unit
testStylesheet =
  Assert.assertEqual
    { actual:
        render
          ( VDom.Elem Nothing
              (VDom.ElemName "link")
              [ Property "rel" (propFromString "stylesheet")
              , Property "type" (propFromString "text/css")
              , Property "href" (propFromString "styles/index.css")
              ]
              []
          )
    , expected: "<link rel=\"stylesheet\" type=\"text/css\" href=\"styles/index.css\"/>"
    }

testScript :: Effect Unit
testScript =
  Assert.assertEqual
    { actual:
        render
          ( VDom.Elem Nothing
              (VDom.ElemName "script")
              [ Property "src" (propFromString "scripts/extra.js?a=1&b=2")
              ]
              []
          )
    , expected: "<script src=\"scripts/extra.js?a=1&b=2\"></script>"
    }

render :: ∀ i w. VDom.VDom (Array (Prop i)) w -> String
render =
  StringRenderer.render
    (const "<!-- I do not know how to render a widget -->")
