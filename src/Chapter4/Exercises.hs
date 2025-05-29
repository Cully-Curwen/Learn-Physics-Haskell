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

printDError :: Double -> [Double] -> IO()
printDError e range = do
  putStrLn "Derivative of f(x) = x³"
  putStrLn $ "numeric = derivative " <> show e
  putStrLn " x | mathmatic | numeric | error "
  let row x = show x <> " | " <> show (dFn' x) <> " | " <> show (derivative e fn' x) <> " | " <> show (dFn' x - derivative e fn' x)
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


