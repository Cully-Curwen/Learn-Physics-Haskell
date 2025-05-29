module Chapter4.Exercises where

-- 4.1
derivative :: Double -> (Double -> Double) -> Double -> Double
derivative e f x = (f (x + e / 2) - f ( x - e / 2)) / e

derivative10 :: (Double -> Double) -> Double -> Double
derivative10 = derivative 10

derivative1 :: (Double -> Double) -> Double -> Double
derivative1 = derivative 1

derivative01 :: (Double -> Double) -> Double -> Double
derivative01 = derivative 0.1

fn :: Double -> Double
fn x = (1 / 2) * x ** 2

xs :: [Double]
xs = [1..10]

printDervs :: IO()
printDervs = do
  putStrLn "derivative 10"
  print $ map (derivative10 fn) xs
  putStrLn "derivative 1"
  print $ map (derivative1 fn) xs
  putStrLn "derivative 1.0"
  print $ map (derivative01 fn) xs

-- derivative 0.1 does not produce the exact id function as 0.1 is not stored perfectly in binary floating point number.
-- This leads to an accumelated rounding point error when computed

-- 4.2
fn' :: Double -> Double
fn' x = x ** 3

dFn' :: Double -> Double
dFn' x = 3 * x ** 2

printDError :: Double -> (Double -> Double) -> (Double -> Double) -> [Double] -> IO()
printDError e f df range = do
  putStrLn "Derivative of f(x) = x³"
  putStrLn $ "numeric = derivative " <> show e
  putStrLn " x | mathmatic | numeric | error "
  let row x = show x <> " | " <> show (df x) <> " | " <> show (derivative e f x) <> " | " <> show (df x - derivative e f x)
  mapM_ (putStrLn . row) range

-- with derivative 1 get a constant error of 0.25
-- with derivative 10 get a constant error of 25
-- with derivative 0.1 get a constant error of 0.0025
-- derivative 2 error 1
-- derivative 3 error 2.25
-- derivative 4 error 4
-- derivative 5 error 6.25
-- error = stepValue ** 2 / 4

onePercentError :: Double -> Double
onePercentError x = sqrt 12 * ( x / 10)

-- 4.3
-- error > 10%, derivative x**3 
-- derivative 0.1 constant error of 0.0025, so need x where (0.0025 / 3*x**2) > 0.1
-- x < (0.025/3) ** (1/2)
-- x < 9.128709291752768e-2
-- so x = 0.09 should create error greater than 10%, yes 10.288065843621437%

-- 4.4
fn'' :: Double -> Double
fn'' = cos
-- using printDError 1 fn'' (\x -> (- (sin x))) [0,(pi/8)..(2*pi)]
--  x | mathmatic | numeric | error 
-- 0.0 | -0.0 | 0.0 | -0.0
-- 0.39269908169872414 | -0.3826834323650898 | -0.36693642135307647 | -1.5747011012013312e-2
-- 0.7853981633974483 | -0.7071067811865475 | -0.6780100988420896 | -2.9096682344457836e-2
-- 1.1780972450961724 | -0.9238795325112867 | -0.8858628849592459 | -3.8016647552040816e-2
-- 1.5707963267948966 | -1.0 | -0.958851077208406 | -4.114892279159399e-2
-- 1.9634954084936207 | -0.9238795325112867 | -0.8858628849592459 | -3.8016647552040816e-2
-- 2.356194490192345 | -0.7071067811865476 | -0.6780100988420898 | -2.9096682344457725e-2
-- 2.748893571891069 | -0.3826834323650899 | -0.3669364213530766 | -1.5747011012013312e-2
-- 3.141592653589793 | -1.2246467991473532e-16 | -1.1102230246251565e-16 | -1.1442377452219667e-17
-- 3.5342917352885173 | 0.38268343236508967 | 0.3669364213530767 | 1.574701101201298e-2
-- 3.9269908169872414 | 0.7071067811865475 | 0.6780100988420896 | 2.9096682344457836e-2
-- 4.319689898685965 | 0.9238795325112865 | 0.8858628849592456 | 3.801664755204093e-2
-- 4.71238898038469 | 1.0 | 0.958851077208406 | 4.114892279159399e-2
-- 5.105088062083414 | 0.9238795325112866 | 0.8858628849592458 | 3.8016647552040816e-2
-- 5.497787143782138 | 0.7071067811865477 | 0.6780100988420898 | 2.9096682344457836e-2
-- 5.890486225480862 | 0.3826834323650904 | 0.36693642135307714 | 1.5747011012013257e-2
-- 6.283185307179586 | 2.4492935982947064e-16 | 2.220446049250313e-16 | 2.2884754904439333e-17
-- ghci> printDError 1 fn'' (\x -> (- (sin x))) [0,(pi/8)..(2*pi)]
--
-- Show that values that;
-- 0, or multiples of pi is least sensative
-- multiples of pi/2 is most sensative
-- any value of a when t = 0 will have good approximation

-- 4.5
type Time = Double
type Position = Double
type Velocity = Double
type Acceleration = Double


pos1 :: Time -> Position
pos1 t = if t < 0
         then 0
         else 5 * t ** 2

vel1Analytic :: Time -> Velocity
vel1Analytic t = if t < 0
                 then 0
                 else 10 * t

acc1Analytic :: Time -> Acceleration
acc1Analytic t = if t < 0
                 then 0
                 else 10

vel1Numerical :: Time -> Velocity
vel1Numerical t = derivative 0.1 pos1 t

acc1Numerical :: Time -> Acceleration
acc1Numerical t = derivative 0.1 vel1Analytic t

-- printDError 0.1 pos1 vel1Analytic [0,5..100]
-- Showed that the only point that differ substantially is at t = 0, where vel1Analytic = 0, vel1Numerical = 0.12500...
-- printDError 0.1 vel1Analytic acc1Analytic [0,5..100]
-- Also at O where acc1Numerical = 5.0, otherwise both are constant at 10
