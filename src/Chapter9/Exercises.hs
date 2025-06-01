module Chapter9.Exercises where

import Chapter6.Exercises (Integration)

type R = Double

oneStep :: R        -- time step
        -> (R -> R) -- function to itegrate
        -> (R,R)    -- curent (t, y)
        -> (R,R)    -- updated (t, y)

oneStep dt f (t,y) = let t' = t + dt
                         y' = y + f t * dt
                     in (t', y')

integral' :: R -> Integration
integral' dt f a b
  = snd $ head $ dropWhile (\(t,_) -> t < b) $
    iterate (oneStep dt f) (a + dt/2, 0)

-- 9.1
polarToCart :: (R, R) -> (R, R)
polarToCart (r,θ) =
  let
    x = r * cos θ
    y = r * sin θ
  in (x, y)

-- 9.2
-- curry take a funcion that takes one input in the form pair, and return a function that take two input
-- uncurry take a function the takes two inputs, and return af function that takes one input in the form of a pair

-- 9.3
headSafe :: [a] -> Maybe a
headSafe [] = Nothing
headSafe (x:_) = Just x

-- 9.4
maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just x) = [x]

-- 9.5
-- When zip is applied to two lists of differing lengths, each element, of each list, starting from the head will be paired together.
-- When one list runs out of element, that is the end of the zipped list

-- 9.6
zip' :: ([a], [b]) -> [(a, b)]
zip' = uncurry zip

-- 9.7
-- zip' . unzip :: [(a, b)] -> [(a, b)] is the id function. As [(a, b)] is a list of pairs, unzip will create ([a], [b]) which will have the same lenghts.
-- unzip . zip' :: ([a], [b]) -> ([a], [b]) is not the id function, as the lists in ([a], [b]) can be differend lengths, so zip can eliminate elements of the longer list.

-- 9.8
-- lookup "Albert Einstein" grades
-- => Just 89
-- lookup "Random Name" grades
-- => Nothing

-- 9.9
fnX :: (R, R, R) -> R
fnX (r, θ, ϕ) = r * (sin θ) * (cos ϕ)

-- 9.10
tvPairs :: [(R, R)]
tvPairs = iterate tvUpdate (0,0)

tvUpdate :: (R, R) -> (R, R)
tvUpdate (t, v) = (t + 1, v + 5)

-- 9.11
fibonacci :: [Int]
fibonacci = [ n | (_,n) <- fibHelper]

fibHelper :: [(Int, Int)]
fibHelper = iterate (\(x,y) -> (y,x + y)) (0,1)

-- 9.12
fact :: Int -> Int
fact n = snd $ factHelper !! n

factHelper :: [(Int, Int)]
factHelper = iterate (\(n,a) -> (n+1, a*(n+1))) (0,1)

-- 9.13
pick13 :: [(R,R,R)] -> [(R,R)]
pick13 triples = [(x1,x3) | (x1,_,x3) <- triples]

-- 9.14
fn914 :: R -> R -> [(R, R, R)]
fn914 t0 tn = [(t,p t,v t) | t <- [t0,t0+dt..tn]]
  where
    v t = v0 + a*t
    p t = v0 + (1/2)*a*t**2
    v0 = 15
    a = -9.8
    dt = (tn-t0)/100

-- 9.15
toTriple :: ((a,b),c) -> (a,b,c)
toTriple ((a,b),c) = (a,b,c)

