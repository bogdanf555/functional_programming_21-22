# Solutions for Lab 8

## Question 8.5.1
Is otherwise a language keyword? If not what is it?

**Response:** It could very well be just a wrapper of the "_", not sure tho.


## Exercise 8.8.1

Test in GHCi: **fact 10000** and **fact 100000** . What takes longer, calculating the number
or printing all of its digits?

**Response:** It takes longer to print the numbers then to actually compute then.

## Question 8.13.1

Enumerate:
1. 2 differences between Elm and Haskell
2. 2 features of Haskell that are not present in SML
3. 2 features of SML that are not present in Haskell

**Response:** 
1. Elm uses keywork **exposing** and Haskell uses **where** for controlling module exporting.
   Also in Haskell can appear Runtime exception which is not possible in Elm.
2. Single line comments and arbitrary precision integers.
3. Explicit constant definitions and it is possible to define a function and its parameter's types in the same line.

# 8.14 Practice problems

## Exercise 8.14.1

Rewrite the sudan function from lab 1 using where in Haskell. The definition is repeated
here for your convenience:

```haskell
sudan 0 x y = x + y
sudan n x y =
    if n > 0 && y == 0 then 
        x 
    else sudan (n - 1) (z) (y + (z))
    where z = sudan n x (y - 1)
```

## Exercise 8.14.2

Define an infix operator called !& in Haskell, which implements the logical function nand
(not and):

```haskell
infix !&

x !& y = if x && y then False else True
```

## Exercise 8.14.8

Implement the safeHead :: [a] -> Maybe a and safeTail :: [a] -> Maybe [a] functions
in Haskell which return Nothing if the list is empty and the result wrapped in Just if it
isn’t empty.

```haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
    

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs
```

## Exercise 8.14.4

Write a function called average :: [Int] -> Float , which calculates the average of a list
of integers.

```haskell
average :: [Int] -> Float
average [] = 0
average l =
    let
        helperFunc l sum count = 
            case l of
                [] -> (fromIntegral sum) / count
                x:xs -> helperFunc xs (sum + x) (count + 1)
    in helperFunc l 0 0
```

## Exercise 8.14.5

Write a function called countVowels which counts the number of vowels in a string:

```haskell
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
```

## Exercise 8.14.8

Write a function called countChar which counts how many times a given string contains
a character. E.g.:

```sml
fun countChar (ch: char) (str: string) : int =
    let
        val str_list : char list = String.explode str
        fun count (ch: char) (l: char list) acc : int =
            case l of
                [] => acc
            |   x::xs =>
                    if x = ch then
                        count ch xs (acc+1)
                    else
                        count ch xs acc;
    in
        count ch str_list 0
    end;

countChar #"a" "lalala";
countChar #"a" "hey";
```