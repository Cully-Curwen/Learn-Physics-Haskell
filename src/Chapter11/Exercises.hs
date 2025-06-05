module Chapter11.Exercises where

import Graphics.Gnuplot.Simple

type R = Double

tRange :: [R]
tRange = [0,0.01..5]

yPos :: R  -- y0
     -> R  -- vy0
     -> R  -- ay
     -> R  -- t
     -> R  -- y
yPos y0 vy0 ay t = y0 + vy0 * t + ay * t**2 / 2

plot1 :: IO ()
plot1 = plotFunc [Title "Projectile Motion"
                 ,XLabel "Time (s)"
                 ,YLabel "Height of projectile (m)"
                 ,PNG "projectile.png"
                 ,Key Nothing
                 ] tRange (yPos 0 20 (-9.8))

plot1Custom :: IO ()
plot1Custom
    = plotFunc [Title "Projectile Motion"
               ,XLabel "Time (s)"
               ,YLabel "Height of projectile (m)"
               ,PNG "CustomLabel.png"
               ,Key Nothing
               ,Custom "label" ["\"Peak Height\" at 1.5,22"]
               ] tRange (yPos 0 20 (-9.8))

customLabel :: (R,R) -> String -> Attribute
customLabel (x,y) label
    = Custom "label" ["\"" ++ label ++ "\"" ++ " at "
                               ++ show x ++ "," ++ show y]

plot2Custom :: IO ()
plot2Custom
    = plotFunc [Title "Projectile Motion"
               ,XLabel "Time (s)"
               ,YLabel "Height of projectile (m)"
               ,Key Nothing
               ,customLabel (1.5,22) "Peak Height"
               ] tRange (yPos 0 20 (-9.8))

plot3Custom :: IO ()
plot3Custom
    = plotPath [Title "Projectile Motion"
               ,XLabel "Time (s)"
               ,YLabel "Height of projectile (m)"
               ,Key Nothing
               ,customLabel (1.5,22) "Peak Height"
               ] [(t, yPos 0 20 (-9.8) t) | t <- tRange]

xRange :: [R]
xRange = [0,0.02..10]

f3 :: R -> R
f3 x = exp (-x)

usePlotFuncs :: IO ()
usePlotFuncs = plotFuncs [] xRange [cos,sin,f3]

xs1, xs2 :: [R]
xs1 = [0,0.1..10]
xs2 = [-5,-4.9..5]

xys1, xys2 :: [(R,R)]
xys1 = [(x,cos x) | x <- xs1]
xys2 = [(x,sin x) | x <- xs2]

usePlotPaths :: IO ()
usePlotPaths = plotPaths [] [xys1,xys2]

usePlotFuncs' :: IO ()
usePlotFuncs' = plotFuncs [ XRange (-2,8)
                          , YRange (-0.2,1)
                          ] xRange [cos,sin,f3]

xRange' :: [R]
xRange' = [-10.0, -9.99 .. 10.0]

sinPath :: [(R,R)]
sinPath = [(x, sin x) | x <- xRange' ]

cosPath :: [(R,R)]
cosPath = [(x, cos x) | x <- xRange' ]

plot4 :: IO ()
plot4 = plotPathsStyle [ Title "Sine and Cosine"
                       , XLabel "x"
                       , YLabel "Function Value"
                       , YRange (-1.2,1.5)
                       ] [ (defaultStyle {lineSpec = CustomStyle
                                          [LineTitle "sin x"]}, sinPath)
                         , (defaultStyle {lineSpec = CustomStyle 
                                          [LineTitle "cos x"]}, cosPath) ]

-- 11.1
plot11_1 :: IO()
plot11_1 = plotFunc [ Title "y = x^2"
                    , XLabel "x-axis"
                    , YLabel "y-axis"
                    , Key Nothing
                    ]
                    [-3.0,-2.9..3.0]
                    y
  where
    y :: R -> R
    y x = x ** 2

-- 11.2
plot11_2 :: IO()
plot11_2 = plotFuncs [Title "cosine and sine"
                     , XLabel "x-axis"
                     , YLabel "y-axis"
                     , Key Nothing
                     , XRange (0, 10)
                     ]
                     [0, 0.2 .. 10::R]
                     [cos, sin]

-- 11.3
ts :: [R]
ts = [0,0.1..6]

txPairs :: [(R,R)]
txPairs = [(t,30 * t - 4.9 * t**2) | t <- ts]

plotTxPairs :: IO()
plotTxPairs = plotPath [Title "Position over Time"
                       , XLabel "Time (s)"
                       , YLabel "Position (m)"
                       , Key Nothing
                       ]
                       txPairs

-- 11.4
approxsin :: R -> R
approxsin x = x - (x**3/fact 3) + (x**5/fact 5) - (x**7/fact 7)
  where 
    fact 0 = 1
    fact n = n * fact (n - 1)

plotApproxsin :: IO()
plotApproxsin = plotPathsStyle [Title "Approximation of sin"
                              , XLabel "x-axis"
                              , YLabel "y-axis"
                              ]
                              [ (defaultStyle {lineSpec = CustomStyle [LineTitle "sin"]}, sinPath')
                              , (defaultStyle {lineSpec = CustomStyle [LineTitle "approxsin"]}, approxsinPath)
                              ]
  where
    range = [-4,-3.99..4]
    sinPath' = [(x,sin x) | x <- range]
    approxsinPath = [(x,approxsin x) | x <- range]
