module Lab9 where

cycl :: [a] -> [a]
cycl l = l++(cycl l)

series :: [[Integer]]
series = [[1]] ++ (map (\x -> (1 + head x):x) series)