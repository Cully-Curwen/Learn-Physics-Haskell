{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use last" #-}
{-# HLINT ignore "Use null" #-}
{-# HLINT ignore "Use cycle" #-}
module Chapter5.Exercises where

type R = Double

-- 5.1
numbers :: [R]
numbers = [-2.0, -1.2, -0.4, 0.4, 1.2, 2.0]

numbers' :: [R]
numbers' = [-2.0, -1.2 .. 2.0]

-- numbers =/= numbes' as numbers' values are affected by Float finite percision accuracy issue

-- 5.2
sndItem0 :: [a] -> a
sndItem0 = head . tail

-- 5.3
-- length "Hello, world" :type = Int, :value = 12

-- 5.4
threeOf :: Int -> [Int]
threeOf x = [x, x, x]
-- the fn creates a list of there copies of an Int

-- 5.5
null' :: [Int] -> Bool
null' xs = 0 == length xs

-- 5.6
last' :: [Int] -> Int
last' xs = head $ reverse xs

-- 5.7
palindrome :: String -> Bool
palindrome w = w == reverse w

-- 5.8
-- 9, 1, -7, -15, -23

-- 5.9
cycle' :: [a] -> [a]
cycle' xs = concat $ repeat xs

-- 5.10
-- a) ["hello", 42] Invalid
-- b) ['h', "ello"] type [String]
-- c) ['a', 'b', 'c'] type String / [Char]
-- d) length ['w', 'h', 'o'] type Int
-- e) length "hello" type Int
-- f) reverse type [a] -> [a]

-- 5.11
-- seem to be that because of floating point persission issue, there is a tolerace value added.
-- so for Float or Double it is not <= n, it is <= (n + tolarence).  fore [x..n]

-- 5.12
euler100 :: Double
euler100 = sum [1 / i**2 | i <- [1..100]]

-- 5.13
fact :: Integer -> Integer
fact n = product [n,n-1..1]

-- 5.14
expList :: R -> [R]
expList x = [(1 + x/n)**n | n <- [1..]]

lTpercent :: Double -> Double -> Int
lTpercent percent x = (+1) $ length $ takeWhile (> percent) [abs $ (exp x - expList x !! n) / exp x | n <- [1..]]

-- to be 1% within x = 1 requires n >= 49
-- to be 1% within x = 10 requires n >= 4968

-- 5.15
expSeries :: R -> [R]
expSeries x = map (\n -> sum [x^k / fromIntegral (product [1..k]) | k <- [0..n]]) [0..]

lTpercent' :: Double -> Double -> Int
lTpercent' percent x = (+1) $ length $ takeWhile (> percent) [abs $ (exp x - expSeries x !! n) / exp x | n <- [1..]]

-- to be 1% within x = 1 requires n >= 4
-- to be 1% within x = 10 requires n >= 18
