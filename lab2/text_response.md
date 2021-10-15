# Answers to questions in the lab document

## Exercise 2.2.1
In order to use the function defined below to display "Dr. Haskell Curry" we should call it this way:

```elm
fullTitle person = (if person.idDr then "Dr. " else "") ++ person.firstName ++ " " ++ person.lstName
fullTitle {idDr = True, firstName = "Haskell", lstName = "Curry"}
"Dr. Haskell Curry" : String
```

## Exercise 2.3.1

### Question: 
Call the fullName function using the User type constructor. Did you encounter anyerrors?

### Response:
By calling the function like in the first try I get "too many arguments error" and "type mismatch error.
But by adjusting the code I made it work.
```elm
-- 1 try
fullName User "Haskell" "Curry"
-- 2 try
fullName (User "Haskell" "Curry")
"Haskell Curry" : String
```

## Question 2.3.1
Does the way type alias works remind you of any keyword in C and C++?
#### Response : typedef

## Exercise 2.3.2

### Define a type alias Address , which includes 4 fields: street, number, city and country.
```elm
type alias Address = {street: String, number: Int, city: String, country: String}
```

## Exercise 2.3.3

### Write a function formatAddress , which takes an instance of an Address and displays it as street number, city, country.
```elm
formatAddress adr = adr.street ++ " " ++ String.fromInt adr.number ++ ", " ++ adr.city ++ ", " ++ adr.country
<function>
    : { a | city : String, country : String, number : Int, street : String } -> String
formatAddress (Address "Baritiu street" 26 "Cluj-Napoca" "Romania")
"Baritiu street 26, Cluj-Napoca, Romania" : String
```

## Exercise 2.5.1

Try to remove the last line ( _ -> "Better luck next time" ) and check if the code could be compiled.
### Response : Missing patterns error pops up because not all the integer values are covered

## Exercise 2.5.2

Try to swap the 1 -> "Gold" and _ -> "Better luck next time" lines. Evaluate the following expressions in the REPL (numberToMedal 1) , (numberToMedal 2), (numberToMedal 10)

### Response: if I place "_" as first option it will raise redundant pattern error

## Review Questions 2.7

### 2.7.1 : What is the cardinality of the Bool type?
2 (is a sum type)
### 2.7.2 : How would you define Int as a sum type? Is the definition valid Elm syntax?

A valid way but exaggerated is to define it as: type Int = One | Two | Three ...;
which is valid elm syntax

### 2.7.3 : What are the built-in types that have cardinality 1 and 0, respectively? Can you define such types (i.e. will the compiler allow it)? What is the use case for such types?

The built in type with cardinality on that I found is: Nothing; couldn't find one with cardinality 0

Well, as I tested you can define types which can have cardinality one as demonstrated below, the only use case I could think of is
to retain someone's information through one's time; It seems you can't define custom types with 0 cardinality. 
```elm
type Student = Bogdan
Bogdan
Bogdan : Student
```

## Practice problems 2.8

### 2.8.1 Define a type for a dice which has six sides.
```elm
type Dice = One | Two | Three | Four | Five | Six
```

### 2.8.2 Define a type DicePair , which contains 2 Dice , in two ways, one using type aliases and one using type definitions.

```elm
type alias DicePair = {first: Dice, second: Dice}
DicePair
<function> : Dice -> Dice -> DicePair
DicePair One Four
{ first = One, second = Four } : DicePair

type DicePair = DicePair {first: Dice, second: Dice}
DicePair
<function> : Dice -> Dice -> DicePair
DicePair One Two
DicePair One Two : DicePair
```
### 2.8.3 Write a function luckyRoll which takes a DicePair and returns a String . It should return “Very lucky” if the roll contains 2 sixes, “Lucky” it contains one six and “Meh” otherwise.
```elm
luckyRoll : DicePair -> String        
luckyRoll (DicePair first second) =
 case (first, second) of
   (Six, Six) -> "Very lucky" 
   (Six, _) -> "Lucky"
   (_, Six) -> "Lucky"
   (_, _) -> "Meh"
```

### 2.8.4 Write the function areaRec for ShapeRec

```elm
type ShapeRec
  = CircleRec { radius : Float }
  | RectangleRec { width : Float, height : Float }
  | TriangleRec { sideA : Float, sideB : Float, sideC : Float }

import Lab2 exposing (..)

areaRec : ShapeRec -> Float
areaRec shape =
  case shape of
    CircleRec {radius} -> pi * radius * radius
    RectangleRec {width, height} -> width * height
    TriangleRec {sideA, sideB, sideC} -> heron sideA sideB sideC
```

### 2.8.5 Define pointInShape method
Defined in PointInShape.elm as "pointInShape". (line 22)

### 2.8.6 Define validateCard method

Defined in Lab2.elm. (line 23)