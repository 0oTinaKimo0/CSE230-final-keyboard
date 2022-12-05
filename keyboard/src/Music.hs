module Music where

import Data.Array

import Euterpea

import Game

shiftKeys :: Int -> Int -> [(Int, Cell)]
shiftKeys coord 0
    | 0 == coord = [(0, (Just Pressed))]
    | otherwise = [(0, (Just Unpressed))]
shiftKeys coord n
    | n == coord = [(n, (Just Pressed))] ++ (shiftKeys coord (n-1))
    | otherwise = [(n, (Just Unpressed))] ++ (shiftKeys coord (n-1))

notesWhite :: [Music Pitch]
notesWhite = [c 4 qn, d 4 qn, e 4 qn, f 4 qn, g 4 qn, a 4 qn, b 4 qn, c 5 qn]

notesBlack :: [Music Pitch]
notesBlack = [cs 4 qn, ds 4 qn, c 1 qn, fs 4 qn, gs 4 qn, as 4 qn, c 1 qn] -- ind 2 6 place holder

notes :: [Music Pitch]
notes = notesWhite ++ notesBlack

-- essential function
playMusic :: Game -> Int -> IO Game
playMusic game coord = do
    play (notes!!coord)
    return game
