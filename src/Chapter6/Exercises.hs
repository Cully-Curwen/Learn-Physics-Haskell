module Chapter6.Exercises where

type R = Double

type AntiDerivative =  R        -- initial value
                    -> (R -> R) -- function
                    -> (R -> R) -- antiderivative of function

antiDerivative :: R -> AntiDerivative
antiDerivative dt v0 a t = v0 + integral dt a 0 t

type Integration = (R -> R) -- function
                 -> R       -- lower limit
                 -> R       -- upper limit
                 -> R       -- result

integral :: R -> Integration
integral dt f a b =
  sum [f t * dt | t <- [a+dt/2, a+3*dt/2 .. b-dt/2]]

-- 6.1
yRock :: R -> R -> R
yRock v0 t = v0 * t + (-9.8 * t**2) / 2

vRock :: R -> R -> R
vRock v0 t = antiDerivative 0.01 v0 (const (-9.8)) t

-- 6.2
-- :t take 4 is [a] -> [a]

-- 6.3
-- :t map :: (a -> b) -> [a] -> [b]
-- :t not :: Bool -> Bool
-- :t map not :: (Bool -> Bool) -> [Bool] -> [Bool]
-- as Bool replaces the a variable, Bool replaces the b variable

-- 6.4
greaterThanOrEq7' :: Int -> Bool
greaterThanOrEq7' n = n > 7 || n == 7

-- 6.5
longerThan :: Int -> String -> Bool
longerThan n w = n < length w
-- longerThan  takes an int and returns a function that checks if a string is longer than the Int

-- 6.6
moreThan6Elm :: [a] -> Bool
moreThan6Elm xs = 6 > length xs

-- 6.7
-- The reason that a list is not returned is because String is a type of ['Char']

-- 6.8
squares :: R -> [R]
squares n = [x**2 | x <- [1,2..n]]
-- squares 1000
-- squares 10 => [1.0,4.0,9.0,16.0,25.0,36.0,49.0,64.0,81.0,100.0]

-- 6.9
repeat' :: a -> [a]
repeat' = iterate id

-- 6.10
replicate' :: Int -> a -> [a]
replicate' r x = take r $ repeat x

-- 6.11
carVel :: [R]
carVel = iterate (\v0 -> v0 + 5) 0
-- take 5 carVel => [0.0,5.0,10.0,15.0,20.0]

-- 6.12
map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]
-- map (flip (**) 2) [1..10] => [1.0,4.0,9.0,16.0,25.0,36.0,49.0,64.0,81.0,100.0]
-- map' (flip (**) 2) [1..10] => [1.0,4.0,9.0,16.0,25.0,36.0,49.0,64.0,81.0,100.0]

-- 6.13
filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs = [x | x <- xs, p x]
-- filter (even) [1..10] == filter' (even) [1..10]
-- True

-- 6.14
average :: [R] -> R
average xs = sum xs / fromIntegral (length xs)

-- 6.15
-- Way Of Thinkig  Input to drop  Output from drop
-- One-input         Int            [a] -> [a]
-- Two-input         Int then [a]      [a]
--
-- Way Of Thinkig  Input to replicate  Output from replicate 
-- One-input            Int             a -> [a]
-- Two-input         Int then a          [a]

-- 6.16
trapIntegrate :: Int       -- # of trapezoids n
              -> (R -> R)  -- function f
              -> R         -- lower limit
              -> R         -- upper limit
              -> R         -- result
trapIntegrate n f a b =
  let dx = (b - a) / fromIntegral n
  in (* dx) . sum . map f $ [1/2 * f a, 1/2 * f b] <> (take (n - 1) $ iterate (\x -> x + dx) (a + dx))

