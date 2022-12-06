module Game where

import Data.Array

data HighLight = Unpressed | Pressed deriving (Eq, Show)
type Cell = Maybe HighLight
data State = Running | Pause | Gener deriving (Eq, Show)

type Board = Array (Int) Cell

data Game = Game { gameBoard :: Board
                 , gameState :: State
                 , prevEvent :: [Int]
                 , genText :: [String]
                 , txtFile :: String
                 } deriving (Eq, Show)

n :: Int
n = 1

whiteN :: Int
whiteN = 8

blackN :: Int
blackN = 5

isWhite :: Int -> Bool
isWhite coord = coord < (n*whiteN)

goBlack :: Int -> Int
goBlack coord = coord + (n*whiteN)

screenWidth :: Int
screenWidth = 640

screenHeight :: Int
screenHeight = 480

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral (n * whiteN)

cellHeight :: Float
cellHeight = fromIntegral screenHeight

blackCellWidth :: Float
blackCellWidth = fromIntegral screenWidth * bWWRatio / fromIntegral (n * whiteN)

blackCellHeight :: Float
blackCellHeight = fromIntegral screenHeight * bWHRatio

bWWRatio :: Float
bWWRatio = 0.8

bWHRatio :: Float
bWHRatio = 0.6

concatList :: [String] -> String
concatList (x:xs) = x ++ " " ++ concatList xs
concatList [] = ""


skip :: IO ()
skip = return ()

-- essential function
initialGame = Game { gameBoard = (array indexRange $ zip (range indexRange) (repeat Nothing)) -- // [(0,(Just Pressed))]
                    , gameState = Pause
                    , prevEvent = []
                    , txtFile = "anger.txt"
                }
                where indexRange = (0, n * (whiteN + blackN))
