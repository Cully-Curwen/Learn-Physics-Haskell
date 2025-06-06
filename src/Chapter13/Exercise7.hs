import Graphics.Gloss

displayMode :: Display
displayMode = InWindow "Axes" (1000, 700) (10, 10)

disk :: Float -> Picture
disk radius = ThickCircle (radius / 2) radius

colorDisk :: Color -> Float -> Picture
colorDisk colour radius = Color colour (disk radius)

rate :: Int
rate = 60

type State = (Float, Bool)

initialState :: State
initialState = (0,True)

displayFunction :: State -> Picture
displayFunction (x,_) = Translate x 0 $ colorDisk red 10

updateFunction :: Float -> State -> State
updateFunction dt (x,increase)
  | x > maxX    = (100, False)
  | x < (-maxX) = (-100, True)
  | otherwise   = (if increase then x + pixInc else x - pixInc, increase)
  where maxX = 100
        pixInc = 100 * dt

main :: IO()
main = simulate displayMode black rate initialState displayFunction (const updateFunction)

