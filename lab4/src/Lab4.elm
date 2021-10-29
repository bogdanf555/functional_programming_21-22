module Lab4 exposing (..)

-- 4.6.1
enumerate: List a -> List (Int, a)
enumerate list = 
  let
    enum : List a -> Int -> (List (Int, a)) -> List (Int, a)
    enum l index acc =
      case l of
        [] -> acc
        x::xs -> enum xs (index + 1) ((index, x)::acc)
    reverse l acc = 
      case l of
        [] -> acc
        x::xs -> reverse xs (x::acc)
  in reverse (enum list 0 []) []

-- 4.6.2
repeat : Int -> a -> List a
repeat n1 elem1 = 
  let
    repeat_helper n elem acc =
      if n == 0 then acc else repeat_helper (n - 1) elem (elem::acc)
  in repeat_helper n1 elem1 []

-- 4.6.3
countVowels : String -> Int
countVowels string =
  let
    string_list = String.toList(string)
    vowels = ['a', 'e', 'i', 'o', 'u']
    isVowel char = List.member char vowels
    count list func acc = 
      case list of
        [] -> acc
        x::xs -> if func x then count xs func (acc + 1) else count xs func acc
  in count string_list isVowel 0

-- 4.6.4
partition : comparable -> List comparable -> (List comparable, List comparable)
partition pivot list =
  let
    filter : (a -> Bool) -> List a -> List a
    filter pred l =
      case l of
        [] -> []
        x::xs -> if (pred x) then x::filter pred xs else filter pred xs
  in (filter (\x -> x < pivot) list, filter (\x -> x >= pivot) list)


-- 4.6.7
all : (a -> Bool) -> List a -> Bool
all pred l = List.foldl (\a b -> a && b ) True (List.map (\x -> pred x) l)