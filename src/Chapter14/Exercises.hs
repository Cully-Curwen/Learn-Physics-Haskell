module Chapter14.Exercises where

import LPFPCore.Newton2 hiding
  ( bikeVelocity
  , positionFtv
  , updateExample
  )
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
                ] [0..10] (positionCF 0.1 (-1) 0.6 [0.04, -0.08])

-- 14.3
sumF :: [R -> R] -> R -> R
sumF fs x = sum $ map ($ x) fs

-- 14.4
positionFv :: R                         --time step
           -> Mass
           -> Position                  -- initial position x(0)
           -> Velocity                  -- initial velocity v(0)
           -> [Velocity -> Force]      -- list of force functions
           -> Time -> Position          -- position function
positionFv dt m x0 v0 fs t = x0 + integral dt (velocityFv dt m v0 fs) 0 t

-- 14.5
bikeVelocity :: Time -> Velocity
bikeVelocity = velocityFtv 1 70 (0,0) [const 100, \(_,v) -> fAir 2 1.225 0.6 v]

-- 14.6
-- ghci> velocityFv 1 70 0 [const 100,fAir 2 1.225 0.6] 1.5
-- 2.835714285714286
-- ghci> velocityFv 0.5 70 0 [const 100, fAir 2 1.225 0.6] 1.5
-- 2.1295044266183036
-- ghci> velocityFv 0.1 70 0 [const 100, fAir 2 1.225 0.6] 1.5
-- 2.1213439486858205

-- 14.7
-- ghci> velocityFtv 0.1 20 (0,0) [\(t,_v) -> pedalCoast t, \(_t,v) -> fAir 1 1.225 0.5 v] 18
-- 2.716452494379447
-- ghci> statesTV 0.1 20 (0,0) [\(t,_v) -> pedalCoast t, \(_t,v) -> fAir 1 1.225 0.5 v] !! (18 * 10)
-- (17.999999999999986,2.716452494379447)

-- 14.8
bikeGraph :: IO ()
bikeGraph = plotFunc [Title "Bike velocity"
                     ,XLabel "Time (s)"
                     ,YLabel "Velocity of Bike (m/s)"
                     ,Key Nothing
                     ] [0,0.5..60] bikeVelocity'
  where bikeVelocity' = velocityFv 0.5 70 0 [const 100, fAir 2 1.225 0.6]

-- 14.9
positionFtv :: R                        -- time step
            -> Mass
            -> Position                 -- initial position x(0)
            -> Velocity                 -- initial velocity v(0)
            -> [(Time,Velocity) -> Force] -- force function
            -> Time -> Position         -- position function
positionFtv dt m x0 v0 fs t = x0 + integral dt (velocityFtv dt m (0,v0) fs) 0 t

-- 14.10
pedalCoastPositionGraph :: IO ()
pedalCoastPositionGraph = plotFunc
        [ Title "Pedal Coast Position"
        , XLabel "time (s)"
        , YLabel "position (m)"
        , Key Nothing
        ] [0,0.1..100]
          (positionFtv 0.1 20 0 0 [\(t,_) -> pedalCoast t, \(_t,v) -> fAir 2 1.225 0.5 v])

-- 14.11
-- |  t  |    v   |
-- |  0  | 2.0000 |
-- | 0.1 | 1.7920 |
-- | 0.2 | 1.6228 |
-- | 0.3 | 1.4661 |

-- 14.12
updateExample :: (Time,Velocity) -- starting state
              -> (Time,Velocity) -- ending state
updateExample (t0,v0) = (t, v)
  where t = t0 + 0.1
        v = v0 + (4*cos (2*t) - 3 * v0) * 0.1
-- ghci> iterate updateExample (0,2) !! 3
-- (0.30000000000000004,1.4661243735415623)

-- 14.13
update13 :: R                   -- time step
         -> (Time, Velocity)    -- initial state
         -> (Time, Velocity)    -- ending state
update13 dt (t0,v0) = (t,v)
  where t = t0 + dt
        v = v0 + (- ((1 * v0) * dt))

exactE :: R
      -> (Time, Velocity)
      -> (Time, Velocity)
exactE dt (t0,_) = (t,v)
  where t = t0 + dt
        v = 8 * exp (- (1 * t))

plot13 :: R -> R -> IO ()
plot13 g b = plotPathsStyle
        [ Title "Euler solutions"
        , XLabel "time (s)"
        , YLabel "velocity (m/s)"
        ] [((defaultStyle{lineSpec = CustomStyle [LineTitle "Exact"]}),exactE')
          ,((defaultStyle{lineSpec = CustomStyle [LineTitle $ "good dt: " ++ show g]}),good)
          ,((defaultStyle{lineSpec = CustomStyle [LineTitle $ "bad dt: " ++ show b]}),bad)]
  where
    plot fn = takeWhile (\(t,_) -> t <= 10) $ iterate fn (0,8)
    good = plot $ update13 g
    bad  = plot $ update13 b
    exactE' = plot $ exactE 0.1

plot13Solution :: IO ()
plot13Solution = plot13 0.01 0.1

-- 14.14
update14 :: R
         -> (Time,Velocity)
         -> (Time,Velocity)
update14 dt (t0,v0) = (t,v)
  where t = t0 + dt
        v = v0 + cos (t0 + v0) * dt

values14 :: [(Time, Velocity)]
values14 = takeWhile (\(t,_) -> t <= 3) (iterate (update14 0.01) (0,0))

plot14 :: IO ()
plot14 = plotPath [ XLabel "time (s)"
                  , YLabel "velocity (m/s)"
                  , Key Nothing
                  ] values14

-- ghci> last values14
-- (2.99999999999998,-0.49960475082864086)

-- 14.15
-- v :: Velocity -> Time -> Velocity
-- t :: Time
-- fTVNet :: Time -> Velocity -> Force
-- /m :: Force -> Mass -> Acceleration
-- xVelocity :: Acceleration -> Time -> Velocity
-- +Velocity :: Velocity -> Velocity -> Velocity
-- +Time :: Time -> Time -> Time

