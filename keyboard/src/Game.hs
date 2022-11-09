module Game where

import Data.Array

data HighLight = Unpressed | Pressed deriving (Eq, Show)
type Cell = Maybe HighLight
data State = Running | Pause deriving (Eq, Show)

type Board = Array (Int) Cell

data Game = Game { gameBoard :: Board
                 , gameState :: State
                 } deriving (Eq, Show)

n :: Int
n = 8

screenWidth :: Int
screenWidth = 640

screenHeight :: Int
screenHeight = 480

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n 

cellHeight :: Float
cellHeight = fromIntegral screenHeight

initialGame = Game { gameBoard = (array indexRange $ zip (range indexRange) (repeat Nothing)) // [(0, (Just Pressed))]
                    , gameState = Running
                }
                where indexRange = (0, n - 1)