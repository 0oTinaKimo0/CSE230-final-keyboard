module Generator where

import Data.Array
import Euterpea
import System.Random

-- 1. fixed feeling
-- 2. random notes/chords/seq generator
-- String -> [Music Pitch]

-- 3. [Music Pitch] -> String

-- notes order [c 4 qn, d 4 qn, e 4 qn, f 4 qn, g 4 qn, a 4 qn, b 4 qn, c 5 qn]
-- dictionary :: [Music Pitch]
-- dictionary = [c 4 qn, d 4 qn, e 4 qn, f 4 qn, g 4 qn, a 4 qn, b 4 qn, c 5 qn]

-- Chords, Hard Coded
dictionary :: [Music Pitch]
dictionary = [chord [c 4 qn, d 4 qn, e 4 qn], chord [d 4 qn, e 4 qn, f 4 qn], chord [e 4 qn, f 4 qn, g 4 qn], 
         chord [f 4 qn, g 4 qn, a 4 qn], chord [g 4 qn, a 4 qn, b 4 qn], chord [a 4 qn, b 4 qn, c 5 qn],
         chord [b 4 qn, c 5 qn, c 4 qn], chord [c 5 qn, c 4 qn, d 4 qn]] 

-- random seed
seed :: Int
seed = 40

generator = mkStdGen seed

score :: String -> [Music Pitch] -> Music Pitch
score word dicts = 
    case word of
        -- fixed word-pitch pairs
        "happy"     -> dicts !! 1
        "sad"       -> dicts !! 2
        "excited"   -> dicts !! 3
        "a"         -> dicts !! 4
        "b"         -> dicts !! 5
        "c"         -> dicts !! 6
        "d"         -> dicts !! 7
        "e"         -> dicts !! 0
        "f"         -> chord [c 4 qn, d 4 qn, e 4 qn]
        -- random generators for word not in dictionary
        otherwise   -> dicts !! rand where
            n = length dicts
            (rand, _) = randomR (0,(n-1)) generator

-- parsed string mapped to music pitch
getScore :: [String] -> [Music Pitch] -> [Music Pitch]
getScore music_str dicts = map (\x -> score x dicts) music_str

inputString :: [String]
inputString = ["I", "am", "happy", "and", "excited"]

outputMusic :: [Music Pitch]
outputMusic = getScore inputString dictionary

printElements :: [String] -> IO()
printElements inputString =  mapM_ print inputString

playMusic :: [Music Pitch] -> IO()
playMusic outputMusic = do
    mapM_ play outputMusic
