module Chapter14.Exercises where

import LPFPCore.Newton2
import Graphics.Gnuplot.Simple

-- 14.1
velocityCF' :: Mass
            -> Velocity         -- initial velocity
            -> [Force]          -- list of forces
            -> Time -> Velocity -- velocity function
velocityCF' m v0 fs t =
  let fNet = sum fs
      a0 = fNet / m
  in v0 + a0 * t

-- 14.2
posAirCar :: IO ()
posAirCar = plotFunc
                [ Title "Position of air car"
                , XLabel "time (s)"
                , YLabel "position (m)"
                , Key Nothing
                ] [0..10] (positionCF 0.1 (-1) 0.6 [0.04, 0.08])

