module Lab2 exposing (..)
import Tuple exposing (first)

output: String
output = "Hello test!"
fullTitle person = (if person.idDr then "Dr. " else "") ++ person.firstName ++ " " ++ person.lstName

numberToMedal : Int -> String
numberToMedal n =
  case n of
    1 -> "Gold"
    2 -> "Silved"
    3 -> "Broze"
    _ -> "Better luck next time"

heron a b c =
  sqrt
    (((a + b + c) / 2)
      * (((a + b + c) / 2) - a)
      * (((a + b + c) / 2) - b)
      * (((a + b + c) / 2) - c)
    )

--- FROM HERE ON IS THE EXERCISE 2.8.6
type alias Month = Int
type alias Year = Int
type Date = Date Month Year
type alias FirstPart = Int
type alias SecondPart = Int
type CardNumber = CardNumber FirstPart SecondPart
type Issuer = Visa | Mastercard
type CreditCard = CreditCard Issuer CardNumber Date

isDateAfter: Date -> Date -> Bool
isDateAfter (Date month1 year1) (Date month2 year2) = 
    (year2 > year1) || (year2 == year1 && month2 > month1)

checkLuhn : String -> Bool
checkLuhn cardNumber = 
  let
    --- this is fromJust definition is a solution I found on stack overflow to the problem:
            --- How to convert a value from type Maybe Int to Int so that I can operate on it
      fromJust : Maybe Int -> Int
      fromJust x = 
        case x of
          Just y -> y
          Nothing -> 0
      len = String.length cardNumber
      sum = fromJust (String.toInt(String.slice (len - 1) len cardNumber))
      parity = modBy 2 (len - 1)

      forLoop : Int -> String -> Int -> Int -> Int
      forLoop index card par summ = 
        let
            digit = fromJust (String.toInt (String.slice index (index + 1) card))

            digit1 dig = if (modBy 2 index) == par then dig * 2 else dig
            digit2 dig = if dig > 9 then dig - 9 else dig
        in if index == (len - 1) then summ else forLoop (index + 1) card par (summ + (digit2 (digit1 digit)))
  in (modBy 10 (forLoop 0 cardNumber parity sum)) == 0

checkMasterCard : Int -> Bool
checkMasterCard number = (number >= 22210000 && number <= 27200000) || (number >= 51000000 && number <= 55000000)
isCardNumberValid : CardNumber -> Issuer -> Bool
isCardNumberValid (CardNumber firstPart secondPart) issuer= 
  (checkLuhn ((String.fromInt firstPart) ++ (String.fromInt secondPart))) && 
  (if issuer == Visa && firstPart >= 40000000 then True else if issuer == Mastercard && (checkMasterCard firstPart) then True else False)