module Main (main) where

import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Logic
import Rendering
import Game

window = InWindow "Keyboard" (700, 500) (100, 100)

backgroundColor = makeColor 255 255 255 255

main :: IO ()
main = play window backgroundColor 30 initialGame gameAsPicture transformGame (const id)