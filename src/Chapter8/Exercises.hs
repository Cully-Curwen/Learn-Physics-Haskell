module Chapter8.Exercises where
import Data.Ratio (denominator)
import GHC.Base (Double)
import GHC.Real (Fractional)

-- 8.1
-- Yes, Integer has type class of Num, Integral, Eq, Order, Show

-- 8.2
-- a) Functions are equal if they share the same Domain, and every input produces the same output
-- b) As the computer would have to check for every possible input, which could tend to infinity
-- c) A purely boolean funciton Bool -> Bool, as there would be only a limited set of input variables and outcomes, in this case 2² = 4

-- 8.3
-- No (/2) and (2/) are not the same, the former is the divisor and later is the dividend. The former will divide an input by two, the later will be 2 divided by the input.

-- 8.4
square :: Double -> Double
square = (**2)

cube :: Double -> Double
cube = (**3)

-- 8.5
-- a) ghci> :i Integer 
-- type Integer :: *
-- data Integer
--   = GHC.Num.Integer.IS ghc-prim-0.11.0:GHC.Prim.Int#
--   | GHC.Num.Integer.IP ghc-prim-0.11.0:GHC.Prim.ByteArray#
--   | GHC.Num.Integer.IN ghc-prim-0.11.0:GHC.Prim.ByteArray#
--         -- Defined in ‘GHC.Num.Integer’
-- instance Integral Integer -- Defined in ‘GHC.Real’
-- instance Num Integer -- Defined in ‘GHC.Num’
-- instance Real Integer -- Defined in ‘GHC.Real’
-- instance Enum Integer -- Defined in ‘GHC.Enum’
-- instance Show Integer -- Defined in ‘GHC.Show’
-- instance Eq Integer -- Defined in ‘GHC.Num.Integer’
-- instance Ord Integer -- Defined in ‘GHC.Num.Integer’
-- instance Read Integer -- Defined in ‘GHC.Read’
--
-- b) ghci> :i Enum
-- type Enum :: * -> Constraint
-- class Enum a where
--   succ :: a -> a
--   pred :: a -> a
--   toEnum :: Int -> a
--   fromEnum :: a -> Int
--   enumFrom :: a -> [a]
--   enumFromThen :: a -> a -> [a]
--   enumFromTo :: a -> a -> [a]
--   enumFromThenTo :: a -> a -> a -> [a]
--   {-# MINIMAL toEnum, fromEnum #-}
--         -- Defined in ‘GHC.Enum’
-- instance Enum Double -- Defined in ‘GHC.Float’
-- instance Enum Float -- Defined in ‘GHC.Float’
-- instance Enum Bool -- Defined in ‘GHC.Enum’
-- instance Enum Char -- Defined in ‘GHC.Enum’
-- instance Enum Int -- Defined in ‘GHC.Enum’
-- instance Enum Integer -- Defined in ‘GHC.Enum’
-- instance Enum Ordering -- Defined in ‘GHC.Enum’
-- instance Enum a => Enum (Solo a) -- Defined in ‘GHC.Enum’
-- instance Enum () -- Defined in ‘GHC.Enum’
-- instance Enum Word -- Defined in ‘GHC.Enum’

-- 8.6
-- a) ghci> :t 42
-- 42 :: Num a => a
-- b) ghci> :t 42.0
-- 42.0 :: Fractional a => a
-- c) ghci> :t 42.5
-- 42.5 :: Fractional a => a
-- d) ghci> :t pi
-- pi :: Floating a => a
-- e) ghci> :t [3,1,4]
-- [3,1,4] :: Num a => [a]
-- f) ghci> :t [3,3.5,4]
-- [3,3.5,4] :: Fractional a => [a]
-- g) ghci> :t [3,3.1,pi]
-- [3,3.1,pi] :: Floating a => [a]
-- h) ghci> :t (==)
-- (==) :: Eq a => a -> a -> Bool
-- i) ghci> :t (/=)
-- (/=) :: Eq a => a -> a -> Bool
-- j) ghci> :t (<)
-- (<) :: Ord a => a -> a -> Bool
-- k) ghci> :t (<=)
-- (<=) :: Ord a => a -> a -> Bool
-- l) ghci> :t (+)
-- (+) :: Num a => a -> a -> a
-- m) ghci> :t (-)
-- (-) :: Num a => a -> a -> a
-- n) ghci> :t (*)
-- (*) :: Num a => a -> a -> a
-- o) ghci> :t (/)
-- (/) :: Fractional a => a -> a -> a
-- p) ghci> :t (^)
-- (^) :: (Num a, Integral b) => a -> b -> a
-- q) ghci> :t (**)
-- (**) :: Floating a => a -> a -> a
-- r) ghci> :t 8/4
-- 8/4 :: Fractional a => a
-- s) ghci> :t sqrt
-- sqrt :: Floating a => a -> a
-- t) ghci> :t cos
-- cos :: Floating a => a -> a
-- u) ghci> :t show
-- show :: Show a => a -> String
-- v) ghci> :t (2/)
-- (2/) :: Fractional a => a -> a

-- 8.7
-- Becasue (/) :: Fractional a => a -> a -> a
-- so as 8 and 4 are type Num p => p, 8/4 has to be type Farctional a => a

-- 8.8
-- the difference between them is how they deal with negative numbers
-- quot and rem tend to zero
-- div and mod tend to negative infinaty
-- what that means is for negative fractions of say -7/3 quot will return -2, as -6 is the closes multiple of 3
-- where as -7/3 mod will return -3, as -9 is the next closes multiple to negative infinity.
-- it is which number is deemed the smaller, -9 or -6

-- 8.9
-- x ^ y        | y :: Int      y :: Integer    y :: Float      y :: Double
-- x :: Int     |    ^              ^
-- x :: Integer |    ^              ^
-- x :: Float   |    ^              ^
-- x :: Double  |    ^              ^

-- x ** y       | y :: Int      y :: Integer    y :: Float      y :: Double
-- x :: Int     |
-- x :: Integer |
-- x :: Float   |                                 **              **
-- x :: Double  |                                 **              **

-- the base cannot be of type class Integral and the exponent be of type class Floating

