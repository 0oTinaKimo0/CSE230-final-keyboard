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
            ,  color black blackKey
             ]



boardAsGenPicture board game =
    pictures [ color highLightColor $ highlightKey board
            ,  color keyColor basicKey
            ,  color black blackKey
            ,  trans (color keyColor (rectangleSolid 510 60))
            ,  trans (color white (rectangleSolid 500 50))
            ,  translate 0 ((fromIntegral screenHeight)/15) (scale 0.2 0.2 (text (concatList (genText game))))
             ]
             where
                trans = translate ((fromIntegral screenWidth)/2.8) ((fromIntegral screenHeight)/12)

-- helper to select the key
snapPictureToCell picture column = shiftedPicture
    where x = fromIntegral column * cellWidth + cellWidth * 0.5
          y = cellHeight * 0.5
          shiftedPicture = case (isWhite column) of 
                            True -> translate x y picture
                            False -> translate ((fromIntegral column) * cellWidth - (fromIntegral screenWidth) + cellWidth )
                                  (fromIntegral screenHeight * (1 - bWHRatio) + blackCellHeight * 0.5)
                                  (rectangleSolid (blackCellWidth*1.2) blackCellHeight)

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
    [0.0 .. fromIntegral (n * whiteN)]

-- black keys
blackKey :: Picture
blackKey =
    pictures
    $ concatMap (\i -> [translate (i * cellWidth)
                                  (fromIntegral screenHeight * (1 - bWHRatio) + blackCellHeight * 0.5)
                                  (rectangleSolid blackCellWidth blackCellHeight)])
    (concatMap (\x -> [x, x + 7.0 .. x + 7.0 * fromIntegral (n-1)]) origLyst)
      where origLyst = [1.0, 2.0, 4.0, 5.0, 6.0]

boardAsPicture board =
    pictures [ highlightKey board
             , basicKey
             , blackKey
             , color white (rectangleSolid 700 200)
             , text "Pause"
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
                        Gener   -> boardAsGenPicture (gameBoard game) game
