import Graphics.Gloss

displayMode :: Display
displayMode = InWindow "Axes" (1000, 700) (10, 10)

disk :: Float -> Picture
disk radius = ThickCircle (radius / 2) radius

colorDisk :: Color -> Float -> Picture
colorDisk colour radius = Color colour (disk radius)

carrotNose :: Picture
carrotNose = Color orange $ ThickArc 95 110 10 20

message :: Picture
message = Scale 0.5 0.5 $ Color red $ Text "Merry Christmas"

stickArm :: Picture
stickArm = Color (makeColorI 128 70 27 255) $ Polygon [(0,2),(20,3),(50,2),(53,10),(57,8),(54,2),(65,1),(65,-3),(50,-2),(0,-2)]

snowMan :: Picture
snowMan = Pictures
  [ Translate 0 (-175) (colorDisk white 100)
  , Translate 0 (-75) (colorDisk white 75)
  , Translate 0 0 (colorDisk white 50)
  , Translate (-10) 15 (colorDisk black 5)
  , Translate 10 15 (colorDisk black 5)
  , Translate (-17) (-8) (colorDisk black 3)
  , Translate 0 (-11) (colorDisk black 3)
  , Translate 17 (-8) (colorDisk black 3)
  , Translate 4 (-12) carrotNose
  , Translate 70 (-75) $ Rotate 330 $ Scale 1.5 1.2 stickArm
  , Translate (-70) (-75) $ Rotate 220 $ Scale 1.5 1.2 stickArm
  , Translate (-200) 70 message
  ]

main :: IO()
main = display displayMode black snowMan
