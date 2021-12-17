import Control.Applicative
import Data.List

-- exercise 11.8.1
data Tree a = Nil | Node (Tree a) a (Tree a) deriving (Show)

instance Functor Tree where
  fmap _ Nil = Nil
  fmap fun (Node z y x) = Node (fmap fun z) (fun y) (fmap fun x)

-- exercise 11.8.2
password n =
  let numbers = sequenceA [['0' .. '9']]
      lowercase = sequenceA [['a' .. 'z']]
      uppercase = sequenceA [['A' .. 'Z']]
   in fmap (\x -> intercalate "" x) (sequenceA (replicate n (numbers ++ lowercase ++ uppercase)))

-- exercise 11.8.3
program :: IO ()
program =
  do
    putStr "Input your weight in kilos\n"
    x <- getLine
    putStr "Input your height in meters\n"
    y <- getLine
    putStr ("Your BMI is " ++ show ((read y :: Double) / ((read x :: Double) * (read x :: Double))) ++ "\n")