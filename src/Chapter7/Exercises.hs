module Chapter7.Exercises where

import Graphics.Gnuplot.Simple
import Chapter6.Exercises
import Chapter2.Exercises

-- 7.1
plot1 :: IO()
plot1 = plotFunc [] [-10,-9.9..10 :: Double] sin

-- 7.2
plot2 :: IO()
plot2 = plotFunc [] [0,0.1..6] yRock30

-- 7.3
plot3 :: IO()
plot3 = plotFunc [] [0,0.1..4] (yRock 20)
