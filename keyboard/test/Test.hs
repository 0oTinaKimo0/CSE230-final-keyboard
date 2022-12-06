{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings   #-}

import Test.Tasty
import Common
import qualified Game as GA
import qualified Logic as L
import qualified Generator  as Gen
import qualified Data.Map as M 

main :: IO ()
main = runTests 
  [ probKey
  , probGen
  ]

probKey ::  Score -> TestTree
probKey sc = testGroup "Keyboard Test" 
  [ scoreTest ((\_ -> GA.concatList ["string", "yeah"]),  (), "string yeah ", 10, "basicTest-1")
  , scoreTest ((\_ -> GA.concatList ["string", "yeah", "woo"]),  (), "string yeah woo ", 10, "basicTest-2")
  , scoreTest ((\_ -> GA.concatList ["string"]),  (), "string ", 10, "basicTest-3")
  , scoreTest ((\_ -> L.mousePosAsCellCoord (0, 0)),  (), 11, 10, "interactiveTest-1")
  , scoreTest ((\_ -> L.mousePosAsCellCoord (10, 11)),  (), 11, 10, "interactiveTest-2")
  , scoreTest ((\_ -> L.mousePosAsCellCoord (200, 100)),  (), 6, 10, "interactiveTest-3")
  ]
  where
    scoreTest :: (Show b, Eq b) => (a -> b, a, b, Int, String) -> TestTree
    scoreTest (f, x, r, n, msg) = scoreTest' sc (return . f, x, r, n, msg)

probGen :: Score -> TestTree
probGen sc = testGroup "Generator"
  [ scoreTest ((\_ -> Gen.removeChar 's' "string"),  (), "tring", 10, "functionalTest-1")
    ,scoreTest ((\_ -> Gen.removeChar 't' "string tw"),  (), "sring w", 10, "functionalTest-2")
    ,scoreTest ((\_ -> Gen.removeChar ' ' "strin g"),  (), "string", 10, "functionalTest-3")
    ,scoreTest ((\_ -> Gen.removeChar 'y' "stringy"),  (), "string", 10, "functionalTest-4")
    ,scoreTest ((\_ -> Gen.removeChar '\"' "\"string\""),  (), "string", 10, "functionalTest-5")
    ,scoreTest ((\_ -> Gen.removeChar '.' "string."),  (), "string", 10, "functionalTest-6")
    ,scoreTest ((\_ -> Gen.removeChar ':' "str:ing"),  (), "string", 10, "functionalTest-7")
    ,scoreTest ((\_ -> Gen.split_word ' ' "s t r i n g"),  (), ["s", "t", "r", "i", "n", "g"], 10, "stringTest-1")
    ,scoreTest ((\_ -> Gen.split_word '!' "o!k"),  (), ["o", "k"], 10, "stringTest-2")
    ,scoreTest ((\_ -> Gen.split_word ' ' ""),  (), [], 10, "stringTest-3")
    ,scoreTest ((\_ -> Gen.split_word '%' "w%h%a%t"),  (), ["w", "h", "a", "t"], 10, "stringTest-4")
  ]
  where
    scoreTest :: (Show b, Eq b) => (a -> b, a, b, Int, String) -> TestTree
    scoreTest (f, x, r, n, msg) = scoreTest' sc (return . f, x, r, n, msg)
