import Graphics.Gloss

displayMode :: Display
displayMode = InWindow "Axes" (1000, 700) (10, 10)

disk :: Float -> Picture
disk radius = ThickCircle (radius / 2) radius

colorDisk :: Color -> Float -> Picture
colorDisk colour radius = Color colour (disk radius)

animatedDisk :: Float -> Float -> Float -> Picture
animatedDisk xScale yScale t = Translate (xScale * sin t) (yScale * cos t) $ colorDisk red 50

main :: IO()
-- main = animate displayMode black $ animatedDisk 200 0
-- main = animate displayMode black $ animatedDisk 200 200
main = animate displayMode black $ animatedDisk 300 200

