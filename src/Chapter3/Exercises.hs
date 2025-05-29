module Chapter3.Exercises where

-- 3.1
-- (False || (True && False) || False) :: Bool
-- (((2 / 3) / 4) == ((4 / 3) / 2))) :: Bool
-- (((7 - (5 / 4)) > 6) || (((2 ^ 5) - 1) == 31)) :: Bool
-- (2 < (3 < 4)) :: not correctly formed cannot compare a numebr and Bool
-- ((2 < 3) && (3 < 4)) :: Bool
-- (2 && (3 < 4)) :: Not correctly formed cannot && a Number

-- 3.2
f :: Double -> Double
f x = if x <= 0
  then 0
  else x

e :: Double -> Double
e r = if r <= 1
  then r
  else 1 / r ** 2

-- 3.3
isXorY :: Char -> Bool
isXorY c = c == 'X' || c == 'Y'

-- 3.4
bagFee :: Bool -> Int
bagFee checkingBags = if checkingBags then 100 else 0

bagFee2 :: Bool -> Int
bagFee2 True = 100
bagFee2 False = 0

-- 3.5
greaterThan50 :: Integer -> Bool
greaterThan50 x = x > 50

-- 3.6
amazingCurve :: Int -> Int
amazingCurve score = if score * 2 > 100 then 100 else score * 2

-- 3.7
-- type bagFee False is Int, value is 0

-- 3.8
circleRadius :: Double
circleRadius = 3.5

cot :: Double -> Double
cot x = 1 / tan x

fe :: Double -> Double
fe epsilon = epsilon * tan (epsilon  * pi / 2)

fo :: Double -> Double
fo epsilon = (- epsilon) * cot (epsilon * pi / 2)

g :: Double -> Double -> Double
g nu epsilon = sqrt (nu ** 2 - epsilon ** 2)

-- 3.9
-- Bool -> Bool; 2¹ so 2, id and not
-- Bool -> Bool -> Bool, will have 2² so 4

-- 3.10
-- If || had higher precedents than && then; False && True || True = False, rather than True

