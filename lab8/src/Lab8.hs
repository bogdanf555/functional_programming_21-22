module Lab8 where

sudan 0 x y = x + y
sudan n x y =
    if n > 0 && y == 0 then 
        x 
    else sudan (n - 1) (z) (y + (z))
    where z = sudan n x (y - 1)

infix !&

x !& y = if x && y then False else True

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
    

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs

average :: [Int] -> Float
average [] = 0
average l =
    let
        helperFunc l sum count = 
            case l of
                [] -> (fromIntegral sum) / count
                x:xs -> helperFunc xs (sum + x) (count + 1)
    in helperFunc l 0 0

countVowels :: String -> Int
countVowels string =
  let
    vowels = ['a', 'e', 'i', 'o', 'u']
    isVowel char = char `elem` vowels
    count list func acc = 
      case list of
        [] -> acc
        x:xs -> if func x then count xs func (acc + 1) else count xs func acc
  in count string isVowel 0