module Logic where

import Data.Array
import Euterpea
import Music
import Game
import Graphics.Gloss.Interface.Pure.Game


isCoordCorrect = inRange (0, n - 1)

-- update board color
playerTurn :: Game -> Int -> IO Game
playerTurn game cellCoord
    | isCoordCorrect cellCoord = do
        return game { prevEvent = (prevEvent game) ++ [cellCoord], gameBoard = board // (shiftKeys cellCoord (n-1))}
    | otherwise = do
        skip
        return game
    where board = gameBoard game

-- locate cell coordinate based on pixel value on the board
mousePosAsCellCoord :: (Float, Float) -> Int
mousePosAsCellCoord (x, y) = floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth)
                            
-- update the board for each round
-- essential function
transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game = 
    case prevEvent game of
        [] -> case gameState game of
                Running -> playerTurn game $ mousePosAsCellCoord mousePos
                Pause -> do
                    skip
                    return initialGame
        otherwise -> return game

-- non-event case
-- essential function
transformGame _ game = do
    skip
    return game

-- reflect on board each round
-- essential function
updateGame _ game = do
    -- three cases each event in order to reduce the delay between sound and color changing
    case (prevEvent game) of
        [] -> return game -- regular case (no update)
        (x:[]) -> do -- there is an incoming event, ready to play sound
            return game { prevEvent = (prevEvent game) ++ [-1]}
        (x:xs) -> do -- played sound and clear the board afterwards
            playMusic game x
            return game { prevEvent = [], gameBoard = board // (shiftKeys (-1) (n-1))}
    where board = gameBoard game