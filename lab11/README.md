# Answers to Lab 11 questions

## Exercise 11.8.1 

Implement the Functor instance for the data Tree a = Nil | Node (Tree a) a (Tree a)
type.

```haskell
data Tree a = Nil | Node (Tree a) a (Tree a) deriving (Show)

instance Functor Tree where
  fmap _ Nil = Nil
  fmap fun (Node z y x) = Node (fmap fun z) (fun y) (fmap fun x)
```

# Exercise 11.8.2

Implement a function passwords that enumerates all n character passwords containing
digits (0 - 9) lowercase letters (a - z) and uppercase letters (A - Z) using the list applicative.

```haskell
password n =
  let numbers = sequenceA [['0' .. '9']]
      lowercase = sequenceA [['a' .. 'z']]
      uppercase = sequenceA [['A' .. 'Z']]
   in fmap (\x -> intercalate "" x) (sequenceA (replicate n (numbers ++ lowercase ++ uppercase)))
```

## Exercise 11.8.3

Write an interactive Haskell program that asks a user for their weight (in kilograms) and
height (in meters) and calculates their BMI using the following formula:
BMI = weight /height2
You can assume that all the inputs will be valid.

```haskell
program :: IO ()
program =
  do
    putStr "Input your weight in kilos\n"
    x <- getLine
    putStr "Input your height in meters\n"
    y <- getLine
    putStr ("Your BMI is " ++ show ((read y :: Double) / ((read x :: Double) * (read x :: Double))) ++ "\n")
```