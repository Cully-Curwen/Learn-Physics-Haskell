{-# OPTIONS_GHC -Wno-name-shadowing #-}
module Chapter10.Exercises where

import LPFPCore.SimpleVec hiding
  ( magAngles
  , gEarth
  , vBall
  , speedRateChangeBall
  , rNCM
  , aPerpFromPosition
  )
import Graphics.Gnuplot.Simple (plotFunc)

-- 10.1
v0 :: Vec
v0 = 20 *^ iHat

v1 :: Vec
v1 = 20 *^ iHat ^-^ 9.8 *^ jHat

v :: R -> Vec
v t = 20 *^iHat ^-^ (9.8 * t) *^ jHat

r :: R -> Vec
r t = 30 *^ jHat ^+^ (20 * t) *^ iHat ^-^ (4.9 * t**2) *^ kHat

x :: R -> R
x t = iHat <.> r t

-- 10.2
vecIntegral :: R          -- step size dt
            -> (R -> Vec) -- vector-valued function
            -> R          -- lower limit
            -> R          -- upper limit
            -> Vec        -- result
vecIntegral dt vF a b =
  sumV [vF t ^* dt | t <- [a+dt/2, a+3*dt/2 .. b-dt/2]]

-- 10.3
maxHeight :: PosVec -> Velocity -> R
maxHeight r v = yComp r + yComp v**2 / (-9.8 * 2)

-- 10.4
speedCA :: Velocity -> Acceleration -> Time -> R
speedCA u a t = magnitude $ velocityCA u a t

-- 10.5
projectileVel :: Velocity -> Time -> Velocity
projectileVel v0 t = v0 ^+^ (9.81 *^ negateV kHat) ^* t

-- 10.6
data Vec2D = Vec2D
  { x2D :: R
  , y2D :: R
  } deriving (Eq)

magAngleFromVec2D :: Vec2D -> (R,R)
magAngleFromVec2D (Vec2D x y) = (sqrt $ x**2 + y**2, atan2 y x)

vec2DFromMagAngle :: (R,R) -> Vec2D
vec2DFromMagAngle (r, theta) = Vec2D (r * cos theta) (r * sin theta)

-- 10.7
xyProj :: Vec -> Vec
xyProj (Vec x y _) = Vec x y 0

-- 10.8
magAngles :: Vec -> (R,R,R)
magAngles vec = (magnitude vec, theta, phi)
  where
    theta = if zComp vec < 0
      then atan (sqrt (xComp vec**2 + yComp vec**2) / zComp vec) + pi
      else atan (sqrt (xComp vec**2 + yComp vec**2) / zComp vec)
    phi = if xComp vec < 0
      then if yComp vec > 0
        then atan (yComp vec / xComp vec) + pi
        else atan (yComp vec / xComp vec) - pi
      else atan (yComp vec / xComp vec)

-- 10.9
gEarth :: Vec
gEarth = Vec 0 (-9.81) 0

vBall :: R -> Vec
vBall t = v0 ^+^ gEarth ^* t
  where
    v0 = Vec (25 * cos ( 52 * pi / 180)) (25 * sin (52 * pi / 180)) 0

speedRateChangeBall :: R -> R
speedRateChangeBall t = speedRateChange (vBall t) gEarth
-- balls rate of change is equal to zero when it is at the pinacle of it tragectury
-- It velocity is not zero, buy the yComp is zero
-- acceleration is constant

plotSRCB :: IO()
plotSRCB = plotFunc [] [0,0.1..4] speedRateChangeBall

-- 10.10
rUCM :: R -> Vec
rUCM t = 2 *^ (cos (6 * t) *^ iHat ^+^ sin (6 * t) *^ jHat)

vUCM :: R -> Vec
vUCM t = (2 * 6) *^ ((-sin (6 * t)) *^ iHat ^+^ cos (6 * t) *^ jHat)

aUCM :: R -> Vec
aUCM t = (-(6**2 * 2)) *^ (cos (6 * t) *^ iHat ^+^ sin (6 * t) *^ jHat)

checkParallel :: [R]
checkParallel = [magnitude $ aParallel (vUCM t) (aUCM t) | t <- [1..10]]

checkMagAcc :: [R]
checkMagAcc = [magnitude $ aPerp (vUCM t) (aUCM t) | t <- [1..10]]

-- 10.11
rNCM :: (R, R -> R) -> R -> Vec
rNCM (radius, theta) t = radius *^ (cos (theta t) *^ iHat ^+^ sin (theta t) *^ jHat)

aPerpFromPosition :: R -> (R -> Vec) -> R -> Vec
aPerpFromPosition epsilon r t =
  let v = vecDerivative epsilon r
      a = vecDerivative epsilon v
  in aPerp (v t) (a t)

theta :: R -> R
theta t = 1/2 * 3 * t**2

rcaAt2 :: Vec
rcaAt2 = aPerpFromPosition 0.1 (rNCM (2, theta)) 2
-- vec (-67.1731324820875) 19.274862779279502 0.0

speedAt2 :: R
speedAt2 = magnitude $ vecDerivative 0.1 (rNCM (2, theta)) 2
-- 11.820808266453575

magnitudeRcaAt2 :: R
magnitudeRcaAt2 = magnitude rcaAt2
-- 69.8838326268396

speed2divR :: R
speed2divR = speedAt2 ** 2 / 2
-- 69.86575403612859
-- So magnitudeRcaAt2 ~= speed2divR
