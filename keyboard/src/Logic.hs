module Logic where

import Data.Array

import Game
import Graphics.Gloss.Interface.Pure.Game

isCoordCorrect = inRange (0, n - 1)
playerTurn :: Game -> Int -> Game
playerTurn game cellCoord
    | isCoordCorrect cellCoord = 
        game { gameBoard = board // [(cellCoord, (Just Pressed))]}
    | otherwise = game
    where board = gameBoard game

mousePosAsCellCoord :: (Float, Float) -> Int
mousePosAsCellCoord (x, y) = floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth)
                            

transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game = 
    case gameState game of
        Running -> playerTurn game $ mousePosAsCellCoord mousePos
        Pause -> initialGame

transformGame _ game = game