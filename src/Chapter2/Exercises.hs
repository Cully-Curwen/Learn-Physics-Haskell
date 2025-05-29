module Chapter2.Exercises where

-- 2.1
sqrt1pluss :: Double -> Double
sqrt1pluss x = sqrt $ 1 + x

-- 2.2
yRock30 :: Double -> Double
yRock30 t = 30 * t + 0.5 * (- 9.8) * t ** 2

-- 2.3
vRock30 :: Double -> Double
vRock30 t = 30 + (- 9.8) * t

-- 2.4
sinDeg :: Double -> Double
sinDeg d = sin $ (d * pi) / 180

-- 2.5
f :: Double -> Double
f x = x ** (1 / 3)

g :: Double -> Double
g y = exp y + 8 ** y

h :: Double -> Double
h x = (1 /) $ sqrt $ (x - 5) ** 2 + 16

gama :: Double -> Double
gama ß = 1 / sqrt (1 - ß ** 2)

u :: Double -> Double
u x = 1 / (10 + x) + 1 / (10 - x)

ł :: Double -> Double
ł l = sqrt $ l * (l - 1)

e :: Double -> Double
e x = 1 / abs x ** 3

e' :: Double -> Double
e' z = 1 / (z ** 2 + 4) ** (3 / 2)

-- 2.6
anon :: Double -> Double
anon = \ß -> 1 / sqrt (1 - ß ** 2)

ex :: Double
ex = anon 0.8

