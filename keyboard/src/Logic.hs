module Logic where

import Data.Array
import Euterpea
import Music
import Game
import Graphics.Gloss.Interface.Pure.Game


isCoordCorrect = inRange (0, n - 1)

changeColor :: Game -> Board -> Int -> IO Game
changeColor game board cellCoord = do
    skip
    return game { gameBoard = board // (shiftKeys cellCoord (n-1))}

playerTurn :: Game -> Int -> IO Game
playerTurn game cellCoord
    | isCoordCorrect cellCoord = do
        playMusic game cellCoord
        return game { gameBoard = board // (shiftKeys cellCoord (n-1))}
    | otherwise = do
        skip
        return game
    where board = gameBoard game



mousePosAsCellCoord :: (Float, Float) -> Int
mousePosAsCellCoord (x, y) = floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth)
                            

transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game = 
    case gameState game of
        Running -> playerTurn game $ mousePosAsCellCoord mousePos
        Pause -> do
            skip
            return initialGame

-- TODO: to make smoother transition between keys
transformGame _ game = do
    skip
    return game

updateGame _ game = do
    skip
    return game --{ gameBoard = board // (shiftKeys (-1) (n-1))}
    -- playMusic game coord
    -- return game { gameBoard = board // (shiftKeys (-1) (n-1))}
    where board = gameBoard game