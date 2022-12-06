module Logic where

import Data.Array
import Data.Fixed
import Euterpea
import Music
import Game
import Graphics.Gloss.Interface.Pure.Game
import Control.Concurrent.Async (async, wait)
import Control.Concurrent.Thread.Delay
import Generator

isCoordCorrect = inRange (0, n*(whiteN + blackN))

-- update board color
playerTurn :: Game -> Int -> IO Game
playerTurn game cellCoord
    | isCoordCorrect cellCoord = do
        return game { prevEvent = (prevEvent game) ++ [cellCoord], gameBoard = board // [(cellCoord, (Just Pressed))]}
    | otherwise = do
        skip
        return game
    where board = gameBoard game

-- locate cell coordinate based on pixel value on the board
mousePosAsCellCoord :: (Float, Float) -> Int
mousePosAsCellCoord (x, y) = case ((y + (fromIntegral screenHeight * 0.5)) < (cellHeight * (1 - bWHRatio))) of
    True ->  floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth) -- Always White
    False -> case isGap || isMissingOne of
        True -> floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth) -- upper white
        False -> goBlack indTranCell -- black case
        where
            xx = (x + (fromIntegral screenWidth * 0.5))
            isGap = posInCell > (cellWidth * bWWRatio)
            isMissingOne = indTranCell == 2 || indTranCell == 6 
            indTranCell = floor (tranCell / cellWidth)
            posInCell = tranCell `mod'` cellWidth
            tranCell = xx - transX * cellWidth
            transX = 1.0 - (bWWRatio/2.0)
            
                            
-- update the board for each round
-- live case (mouse event)
transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game = 
    case prevEvent game of
        [] -> case gameState game of
                Running -> playerTurn game $ mousePosAsCellCoord mousePos
                Pause -> do
                    skip
                    return initialGame
                Gener -> 
                    return game
        otherwise -> return game

transformGame (EventKey (Char 'p') Up _ mousePos) game = 
    case gameState game of
        Running -> return game
        Pause -> return game
        Gener -> do 
                    playGen (genText game)
                    -- close handle
                    return game

transformGame (EventKey (Char 'c') Up _ mousePos) game = 
    case gameState game of
        Running -> return game
        Pause -> return game 
        Gener -> case (txtFile game) of
            "anger.txt" -> return game {txtFile = "love.txt"}
            "love.txt" -> return game {txtFile = "user.txt"}
            "user.txt" -> return game {txtFile = "anger.txt"}

-- switch case (space)
transformGame (EventKey (SpecialKey KeySpace) Up _ _) game = 
    case gameState game of
        Pause -> return game {gameState = Running}
        Running -> do {text <- (textHandler game); return game {gameState = Gener, genText = text}}
        Gener -> return game {gameState = Pause}

-- non-event case
-- essential function
transformGame _ game = do
    skip
    return game

-- reflect on board each round
-- essential function
updateGame _ game = do
    case gameState game of
        Running -> case (prevEvent game) of
                        [] -> return game -- regular case (no update)
                        (x:xs) -> do -- played sound and clear the board afterwards
                            -- _ <- async (playMusic game x)
                            playMusic game x
                            -- delay 100000
                            return game { prevEvent = xs, gameBoard = (gameBoard game) // [(x, (Just Unpressed))]}
        Pause -> return game
        Gener -> do {text <- (textHandler game); return game {genText = text}}
    -- three cases each event in order to reduce the delay between sound and color changing
    