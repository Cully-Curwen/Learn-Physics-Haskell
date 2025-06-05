
main :: IO()
main = print $ powers2 20

powers2 :: Int -> [Int]
powers2 n = [2 ^ i | i <- [0..n]]

