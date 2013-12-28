import Graphics.Implicit
import Graphics.Implicit.Primitives (rotateExtrude, rotate3)
import Graphics.Implicit.Primitives (getBox, getImplicit)

import qualified Prelude as P
import Prelude hiding ((+),(-),(*),(/))

import Graphics.Implicit.Definitions
import Graphics.Implicit.SaneOperators

deg2rad :: ℝ -> ℝ
deg2rad x = x P./ 180.0 P.* pi

rot :: ℝ3 -> SymbolicObj3 -> SymbolicObj3
rot (degx, degy, degz) =
  let (ax, ay, az) = (deg2rad degx, deg2rad degy, deg2rad degz) in
  -- This rotation matrix is copied from
  -- http://en.wikipedia.org/wiki/Rotation_formalisms_in_three_dimensions
  let rotx = (cos ay * cos az,
              cos ax * sin az + sin ax * sin ay * cos az,
              sin ax * sin az - cos ax * sin ay * cos az) in
  let roty = (-cos ay * sin az,
              cos ax * cos az - sin ax * sin ay * sin az,
              sin ax * cos az + cos ax * sin ay * sin az) in
  let rotz = (sin ay, -sin ax * cos ay, cos ax * cos ay) in
  \obj ->
    implicit (\vec -> getImplicit obj (rotx ⋅ vec, roty ⋅ vec, rotz ⋅ vec))
             (let ((x1,y1,z1),(x2,y2,z2)) = getBox obj in
              let min1 = minimum [x1, y1, z1] P.* sqrt 3 in
              let max2 = maximum [x2, y2, z2] P.* sqrt 3 in
              ((min1,min1,min1),(max2,max2,max2)))

-- Mirror in the y=z plane
swapyz obj =
  implicit (\(x,y,z) -> getImplicit obj (x,z,y))
           (let ((x1,y1,z1),(x2,y2,z2)) = getBox obj in
            ((x1,z1,y1),(x2,z2,y2)))

straight r l = extrudeR 0 (circle r) l

straightAnd r l next =
  union [
    straight r l,
    translate (0,0,l) next
  ]

turn r rturn a =
  rot (90,0,0) $ -- swapyz $ --rotate3 (0,0,0) $
  translate (-rturn,0,0) $
  rotateExtrude a (Just 0) (Left (0,0)) $
  translate (rturn,0) $
  circle r

turnAnd r rturn a next =
  union [
    turn r rturn a,
    translate (-rturn,0,0) $
    rot (0,-a,0) $
    translate (rturn,0,0) next
  ]

data Section = Straight ℝ | Turn ℝ ℝ
type Tube = (ℝ, [Section])

tube :: Tube -> SymbolicObj3
tube (r, [Straight l]) = straight r l
tube (r, Straight l : next) = straightAnd r l (tube (r, next))
tube (r, [Turn rturn a]) = turn r rturn a
tube (r, Turn rturn a : next) = turnAnd r rturn a (tube (r, next))

--tubes = straightAnd 2 10 $ turnAnd 2 10 45 $ straight 2 5
tubes = tube (2, [
    Straight 5,
    Straight 5,
    Turn 10 40,
    Straight 5 ])

main = do
  putStrLn "Rendering..."
  writeSTL 1 "tubes.stl" tubes
