module Music where

import Data.Array

import Euterpea

import Game

-- notes order [c 4 qn, d 4 qn, e 4 qn, f 4 qn, g 4 qn, a 4 qn, b 4 qn, c 5 qn]
shiftKeys :: Int -> Int -> [(Int, Cell)]
shiftKeys coord 0
    | 0 == coord = [(0, (Just Pressed))]
    | otherwise = [(0, (Just Unpressed))]
shiftKeys coord n
    | n == coord = [(n, (Just Pressed))] ++ (shiftKeys coord (n-1))
    | otherwise = [(n, (Just Unpressed))] ++ (shiftKeys coord (n-1))


notes :: [Music Pitch]
notes = [c 4 qn, d 4 qn, e 4 qn, f 4 qn, g 4 qn, a 4 qn, b 4 qn, c 5 qn]

-- essential function
playMusic :: Game -> Int -> IO Game
playMusic game coord = do
    play (notes!!coord)
    return game { gameBoard = board // (shiftKeys (-1) (n-1))} 
        where board = gameBoard game