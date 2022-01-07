# Solutions for lab 12

## Exercise 12.1.1

Create a new parser using satisfies , char :: Char -> Parser Char that generates a
parser that parses a given character (received as first argument).

```haskell
import qualified Parser as P
char :: Char -> P.Parser Char
char c = P.satisfies (== c) "Unexpected character"
```


## Exercise 12.1.2

Create a new parser using digit :: Parser Char that parses a digit.
Haskel

```haskell
import qualified Parser as P
digit :: P.Parser Char
digit = P.satisfies (\x -> x `elem` ['0' .. '9']) "digit parser"
```

## Exercise 12.2.1

Create a new parser for strings, string’ , that only uses the combinators defined so far
( andThen , orElse and pMap ), without using inner functions.

```haskell
string' :: String -> P.Parser String
string' "" = P.succeed ""
string' (c : str) = P.pMap (\(a, b) -> a : b) (P.andThen (char c) (string' str))
```

## Exercise 12.2.2

Create a new parser number :: Parser Int that parses a number.

```haskell
number :: P.Parser Int
number = P.pMap read (P.some digit)
```

## Exercise 12.3.1

Create a new combinator pThen :: Parser a -> Parser b -> Parser b . First, it runs the
first parser, pa . If pa succeeds, it discards the result and runs pb on the remaining
input from pa . If pa fails, the error is returned.

```haskell
pThen :: P.Parser a -> P.Parser b -> P.Parser b
pThen parserA parserB = P.pMap (\(x, y) -> y) (P.andThen parserA parserB)
```