module Rendering where

import Data.Array

import Graphics.Gloss

import Game

highLightColor = makeColorI 255 255 50 255
keyColor = makeColorI 50 100 255 255
pauseColor = greyN 0.5

boardAsRunningPicture board =
    pictures [ color highLightColor $ highlightKey board
            ,  color keyColor basicKey
             ]

-- helper to select the key
snapPictureToCell picture column = translate x y picture
    where x = fromIntegral column * cellWidth + cellWidth * 0.5
          y = cellHeight * 0.5

-- helper to filter and return the colored picture
cellsOfBoard :: Board -> Cell -> Picture -> Picture
cellsOfBoard board cell cellPicture =
    pictures
    $ map (snapPictureToCell cellPicture . fst)
    $ filter (\(_, e) -> e == cell)
    $ assocs board

hKey :: Picture
hKey = rectangleSolid cellWidth cellHeight

-- action function
highlightKey :: Board -> Picture
highlightKey board = cellsOfBoard board (Just Pressed) hKey

-- basic non-colored board
basicKey :: Picture
basicKey = 
    pictures
    $ concatMap (\i -> [ line [(i * cellWidth, 0.0)
                                , (i * cellWidth, fromIntegral screenHeight)
                                ] 
                        , line [ (0.0, i * cellHeight)
                              , (fromIntegral screenWidth, i * cellHeight)
                              ]          
                        ])
    [0.0 .. fromIntegral n]

boardAsPicture board =
    pictures [ highlightKey board
             , basicKey
             ]

boardAsPause board = color pauseColor (boardAsPicture board)

-- essential function
gameAsPicture :: Game -> IO Picture
gameAsPicture game = do
    skip
    return (translate (fromIntegral screenWidth * (-0.5))
                    (fromIntegral screenHeight * (-0.5))
                    frame)
    where frame = case gameState game of
                        Running -> boardAsRunningPicture (gameBoard game)
                        Pause   -> boardAsPause (gameBoard game)