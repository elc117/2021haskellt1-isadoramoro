import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)

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
angRotation n = [(i, 400, 300) | i <- take n(iterate (+20) a)]
  where a = 20
-------------------------------------------------------------------------------
strkStyle :: (Int,Int,Int) -> String
strkStyle (r,g,b) = printf "stroke:rgb(%d,%d,%d);fill-opacity:0.0;" r g b

newPalette :: Int -> [(Int,Int,Int)]
newPalette n = take n [(a+3*i, a+2*i, a)| i <- take n(iterate (+20) a)]
  where a = 6
-------------------------------------------------------------------------------
genRects :: Int -> [Rect]
genRects n = replicate n ((x,y), w, h)
  where x = 400
        y = 300
        w = 150
        h = 150
-------------------------------------------------------------------------------
svgElements :: [(Rect, String, String)] -> String
svgElements elements = concat $ map svgRect elements

--teste:
--concat(map svgRect (zipWith3 (,,) (genRects 2) (map rotation (angRotation 2)) (map strkStyle (newPalette 2)))) --OK
-------------------------------------------------------------------------------
main :: IO()
main = do 
  writeFile "trab1.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ part1 ++ svgEnd
        part1 = svgElements (zipWith3 (,,) rects transform style)
        rects = genRects nrects
        transform = (map rotation (angRotation nrects))
        style = (map strkStyle palette)
        palette = newPalette nrects
        nrects = 18
        (w,h) = (800,600)