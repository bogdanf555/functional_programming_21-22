
module PointInShape exposing (..)

type alias Point = {x: Float, y: Float}
type Shape2D
  = Circle {center: Point, radius: Float}
  | Rectangle {topLeftCorner: Point, bottomRightCorner: Point}
  | Triangle {pointA: Point, pointB: Point, pointC: Point}

heron : Float -> Float -> Float -> Float
heron a b c =
  sqrt
    (((a + b + c) / 2)
      * (((a + b + c) / 2) - a)
      * (((a + b + c) / 2) - b)
      * (((a + b + c) / 2) - c)
    )

euclidianDistance2D : Point -> Point -> Float
euclidianDistance2D first second = sqrt ((first.x - second.x) ^ 2 + (first.y - second.y) ^ 2)

pointInShape : Point -> Shape2D -> Bool
pointInShape point shape =
  case shape of
    Circle {center, radius} -> (euclidianDistance2D point center) < radius
    Rectangle {topLeftCorner, bottomRightCorner} -> (topLeftCorner.x < point.x && point.x < bottomRightCorner.x) && (topLeftCorner.y < point.y && point.y < bottomRightCorner.y)
    Triangle {pointA, pointB, pointC} -> 
      let
        w1 = (pointA.x * (pointC.y - pointA.y) + (point.y - pointA.y) * (pointC.x - pointA.x) + point.x * ((pointC.y - pointA.y))) / ((pointB.y - pointA.y) * (pointC.x - pointA.x) - (pointB.x - pointA.x) * (pointC.y - pointA.y))       
        w2 = (point.x - pointA.y - w1 * (pointB.y - pointA.y)) / (pointC.y - pointA.y)
      in (w1 >= 0 && w2 >= 0 && (w1 + w2) < 1)