module Lab3 exposing (..)
import Shape exposing (..)

-- 3.5.2
len : List a -> Int
len list = 
  let
    lenHelper list1 count = 
      case list1 of
        [] -> count
        x::xs -> lenHelper xs (count + 1)
    in lenHelper list 0

countFromTo : Int -> Int -> List Int
countFromTo from1 to1 =
  let
    countFromToAux from to aux = 
      if from >= to then
        aux
      else
        countFromToAux (from + 1) to (from::aux)
  in countFromToAux from1 to1 []

-- 3.5.1
safeDiv : Int -> Int -> Maybe Int
safeDiv first second = 
  case second of
    0 -> Nothing
    _ -> Just (first // second)

-- 3.5.3
last : List a -> Maybe a
last l = 
  case l of
    [] -> Nothing
    x::[] -> Just x
    x::xs -> last xs

-- 3.5.4
tail l = 
    case l of
      [] -> []
      x::xs -> xs

indexList : Int -> List a -> Maybe a
indexList i l = 
  let
    indexListHelper : Int -> List a -> Int -> Maybe a
    indexListHelper ii ll current = 
      if current == ii then
        List.head ll
      else
        indexListHelper ii (tail ll) (current + 1)
  in indexListHelper i l 0

-- 3.5.5 and 3.5.6 (modified the code to comply with 3.5.6)
fibs : Int -> Int -> List (Int, Int)
fibs start end =
    let
      reverse l = 
        let
          reverseHelper ll aux = 
            case ll of
              [] -> aux
              x::xs -> reverseHelper xs (x::aux)
        in reverseHelper l []
      fibo n1 n2 first second index l = 
        if index >= n2 then
          l 
        else if index >= n1 then 
          fibo n1 n2 second (first + second) (index + 1) ((index, second)::l)
        else
          fibo n1 n2 second (first + second) (index + 1) l
    in reverse (fibo start end 0 1 0 [])

-- 3.5.7
cmpShapes : Shape -> Shape -> Result String Order
cmpShapes shape1 shape2 = 
  let
    area1 = safeArea shape1
    area2 = safeArea shape2
  in
    case (area1, area2) of
       (Err str1, Err str2) -> Err (String.concat ["Invalid input for both shapes: ", str1, "; ", str2])
       (Err str1, _) -> Err (String.concat ["Invalid input for first shape: ", str1])
       (_, Err str1) -> Err (String.concat ["Invalid input for second shape: ", str1])
       (Ok a1, Ok a2) -> (Ok (compare a1 a2))

-- 3.5.8
totalArea : List Shape -> Result (Int, InvalidShapeError) Float
totalArea list =
  let
    totalAreaHelper l index area =
      case l of
         [] -> (Ok area)
         x::xs -> 
          let
            safe = (safeAreaEnum x)
          in
            case safe of
              Ok a1 -> totalAreaHelper xs (index + 1) (area + a1)
              Err error -> Err (index, error)
  in totalAreaHelper list 0 0