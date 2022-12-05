module Generator where

import Data.Array
import Euterpea
import System.Random
import System.IO
import qualified Data.Set as Set

-- 1. fixed feeling
-- 2. random notes/chords/seq generator
-- String -> [Music Pitch]

-- 3. [Music Pitch] -> String

-- Chords, Hard Coded
-- To Do: add more notes/chord/lines
anger_dicts :: [Music Pitch]
anger_dicts = [chord [fs 3 qn, b 3 qn, ds 4 qn, fs 4 qn], chord [fs 3 qn, b 3 qn, d 4 qn, fs 4 qn], 
               chord [f 3 qn, gs 3 qn, c 4 qn, f 4 qn], chord [gs 3 qn, cs 4 qn, e 4 qn, gs 4 qn]]

-- To Do: add more notes/chord/lines
love_dicts :: [Music Pitch]
love_dicts = [line [b 3 sn, d 4 sn, fs 4 sn, b 3 sn, d 4 sn, fs 4 sn], line [d 4 sn, g 4 sn, b 4 sn, d 4 sn, g 4 sn, b 4 sn], 
              line [a 3 sn, cs 4 sn, e 4 sn, a 3 sn, cs 4 sn, e 4 sn]]

-- To Do: add more notes/chord/lines
other_dicts :: [Music Pitch]
other_dicts = [line [c 4 qn, d 4 qn, e 4 qn], line [d 4 qn, e 4 qn, f 4 qn], line [e 4 qn, f 4 qn, g 4 qn], 
         line [f 4 qn, g 4 qn, a 4 qn], chord [g 4 qn, a 4 qn, b 4 qn], chord [a 4 qn, b 4 qn, c 5 qn],
         chord [b 4 qn, c 5 qn, c 4 qn], chord [c 5 qn, c 4 qn, d 4 qn]] 

-- word -> {words}
happy_set = Set.fromList ["love", "story", "baby", "say", "yes"]
anger_set = Set.fromList ["rage", "against", "dying", "light"]

-- dicts = [anger_dicts, love_dicts, other_dicts]
-- sets = [happy_set, anger_set]

-- random seed
seed :: Int
seed = 40000

generator = mkStdGen seed

-- To Do: [Music Pitch] -> [Music Pitch] -> [Music Pitch] => [[Music Pitch]]

score :: String -> Music Pitch
score word = do
    if (Set.member word happy_set) then
        let 
            n = length love_dicts
            (rand, _) = randomR (0,(n-1)) generator
        in
            love_dicts !! rand
    else if (Set.member word anger_set) then
        let 
            n = length anger_dicts
            (rand, _) = randomR (0,(n-1)) generator
        in
            anger_dicts !! rand
    else 
        let 
            n = length other_dicts
            (rand, _) = randomR (0,(n-1)) generator
        in
            other_dicts !! rand 


-- parsed string mapped to music pitch
getScore :: [String] -> [Music Pitch] -> [Music Pitch] -> [Music Pitch] -> [Music Pitch]
getScore music_str anger_dicts love_dicts other_dicts = map (\x -> score x) music_str

-- parse input string
split_word :: Char -> String -> [String]
split_word _ "" = []
split_word c s = firstWord : (split_word c rest)
    where firstWord = takeWhile (/=c) s
          rest = drop (length firstWord + 1) s

removeChar :: Char -> String -> String
removeChar _ [] = []
removeChar ch (c:cs)
    | c == ch   = removeChar ch cs
    | otherwise = c:(removeChar ch cs)

main = do
    handle <- openFile "anger.txt" ReadMode
    contents <- hGetContents handle
    let input = (map (removeChar '"') (split_word ' ' contents))
    print input
    hClose handle
    let outputMusic = getScore input anger_dicts love_dicts other_dicts
    do
        mapM_ play outputMusic