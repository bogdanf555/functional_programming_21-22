
module LazyLists where

import Prelude hiding (Left, Right)

ins x [] = [x]
ins x (y:ys)
  | x <= y = x:y:ys
  | otherwise = y:(ins x ys)

insSort [] = []
insSort (x:xs) = ins x (insSort xs)

lazyMin l = head (insSort l)

merge3 x y z = merge (merge x y) z where
  merge (u:us) (v:vs)
    | u < v = u:merge us (v:vs)
    | u > v = v:merge (u:us) vs
    | otherwise = u:merge us vs

hammingGen n = take n ham where
  ham = 1:merge3 
    [ 2*i | i <- ham ]
    [ 3*i | i <- ham ]
    [ 5*i | i <- ham ]

