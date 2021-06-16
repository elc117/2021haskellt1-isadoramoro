import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)
type Ellipse    = (Point,Float,Float)

-------------------------------------------------------------------------------
-- String inicial do SVG
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgEnd :: String
svgEnd = "</svg>"
-------------------------------------------------------------------------------
svgRect :: (Rect, String, String) -> String 
svgRect (((x,y),w,h), rot, style) = 
  printf "<rect x='%f' y='%f' width='%f' height='%f' transform='%s' style='%s' />\n" x y w h rot style
-------------------------------------------------------------------------------
rotation :: (Int,Int,Int) -> String
rotation (a, x, y) = printf "rotate(%d,%d,%d)" a x y

angRotation :: Int -> [(Int,Int,Int)]
angRotation n = [(ang, 400, 300) | ang <- take n(iterate (+a) a)]
  where a = 20
-------------------------------------------------------------------------------
strkStyle :: (Int,Int,Int, Float) -> String
strkStyle (r,g,b,o) = printf "stroke:rgb(%d,%d,%d);fill-opacity:%f;" r g b o

newPalette :: Int -> [(Int,Int,Int, Float)]
newPalette n = take n [((div a 2), a, i, o)| i <- take n(iterate (+b) 0)]
  where a = 255
        b = 25
        o = 0.0
-------------------------------------------------------------------------------
genRects :: Int -> [Rect]
genRects n = replicate n ((x,y), w, h)
  where x = 400
        y = 300
        w = 150
        h = 150
-------------------------------------------------------------------------------
svgElements :: [((Point,Float,Float), String, String)] -> String
svgElements elements = concat $ map svgRect elements
-------------------------------------------------------------------------------
svgEllipse :: (Ellipse, String) -> String
svgEllipse (((cx,cy), rx, ry), style) =
  printf "<ellipse cx='%f' cy='%f' rx='%f' ry='%f' style='%s' />\n" cx cy rx ry style

elPalette :: Int -> [(Int,Int,Int,Float)]
elPalette n = take n [(a+i, a+2*i, a+3*i, o) | i <- take n(iterate (+10) a)]
  where a = 6
        o = 0.0

genEllip :: Int -> [Ellipse]
genEllip n = replicate n ((cx,cy), rx, ry)
  where cx = 400
        cy = 300
        rx = 212
        ry = 212

svgElements1 :: [((Point,Float,Float), String)] -> String
svgElements1 elements = concat $ map svgEllipse elements
-------------------------------------------------------------------------------
main :: IO()
main = do 
  writeFile "trab1.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ part1 ++ part2 ++ svgEnd
        part1 = svgElements (zipWith3 (,,) rects transform style)
        rects = genRects nrects
        transform = (map rotation (angRotation nrects))
        style = (map strkStyle palette)
        palette = newPalette nrects
        nrects = 18

        part2 = svgElements1 (zipWith (,) ellip (map strkStyle color))
        ellip = genEllip nellip
        color = elPalette nellip
        nellip = 3

        (w,h) = (800,600)