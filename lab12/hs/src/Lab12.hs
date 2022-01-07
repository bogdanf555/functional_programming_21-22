import qualified Parser as P
import Result

char :: Char -> P.Parser Char
char c = P.satisfies (== c) "Unexpected character"

digit :: P.Parser Char
digit = P.satisfies (\x -> x `elem` ['0' .. '9']) "digit parser"

string' :: String -> P.Parser String
string' "" = P.succeed ""
string' (c : str) = P.pMap (\(a, b) -> a : b) (P.andThen (char c) (string' str))

number :: P.Parser Int
number = P.pMap read (P.some digit)

pThen :: P.Parser a -> P.Parser b -> P.Parser b
pThen parserA parserB = P.pMap (\(x, y) -> y) (P.andThen parserA parserB)