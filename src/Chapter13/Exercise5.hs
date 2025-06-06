import Graphics.Gloss

displayMode :: Display
displayMode = InWindow "Axes" (1000, 700) (10, 10)

disk :: Float -> Picture
disk radius = ThickCircle (radius / 2) radius

colorDisk :: Color -> Float -> Picture
colorDisk colour radius = Color colour (disk radius)

alternatingDiskColor :: Float -> Picture
alternatingDiskColor n = colorDisk (if n < (-339) then blue else red) 10

rate :: Int
rate = 60

type State = (Float, Float)

initialState :: State
initialState = (0,340 * cos (abs (0)))

displayFunction :: State -> Picture
displayFunction (x,y) = Translate x y $ alternatingDiskColor y

updateFunction :: Float -> State -> State
updateFunction dt (x,_) = (x + 1 * dt, 340 * cos (abs x))

main :: IO()
main = simulate displayMode black rate initialState displayFunction (const updateFunction)

