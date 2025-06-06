import Graphics.Gloss

displayMode :: Display
displayMode = InWindow "Axes" (1000, 700) (10, 10)

disk :: Float -> Picture
disk radius = ThickCircle (radius / 2) radius

colorDisk :: Color -> Float -> Picture
colorDisk colour radius = Color colour (disk radius)

animatedDisk :: Float -> Picture
animatedDisk t = Translate (10 * t) (-5 * t) $ colorDisk red 50

main :: IO()
main = animate displayMode black animatedDisk

