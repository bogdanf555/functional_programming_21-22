# Answers to questions lab 4

## Questions

## 5.2.1 Which is the core difference between function composition and pipelines?
Function composition returns a function and pipelines return other types bases on the return type of the functions involved.

## 5.2.2 In which cases is it more elegant to use:
* function composition ( >> and << ) over pipelines ( |> and <| )
* pipelines ( |> and <| ) over function composition ( >> and << )

Function composititon over pipelines when you want to use the newly created function more than once in your code.
Pipelines if it is a single time use.

## 5.2.3 How can we rewrite a function that uses:
* function composition ( >> and << ) to a function that uses only pipelines ( |> and <| )
* functions that use pipelines ( |> and <| ) to a function that uses only function
composition ( >> and << )

In the first case using lambdas. In the second case calling like this e.g. (f >> g) 5

## Exercises 

## 5.2.1 Trace the evaluation of applyTwice (inc >> triple) 1 , showing each evaluation step
This is retriving the value 14. 1 => 2 => 6 => 7 => 14

## 5.2.2 Implement the all and any functions by using a pipeline with map then foldl.

```elm
all : (a -> Bool) -> List a -> Bool
all pred l = List.foldl (\a b -> a && b ) True <| (List.map (\x -> pred x) l)

any : (a -> Bool) -> List a -> Bool
any pred l = List.foldl (\a b -> a || b ) False <| (List.map (\x -> pred x) l)
```

## 5.5.1 Write the implementation of the map2: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c function for Maybe.

```elm
map2: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
map2 f ma mb =
  case (ma, mb) of
    (Nothing, _) -> Nothing
    (_, Nothing) -> Nothing
    (Just a, Just b) -> Just (f a b)
```

## 5.8.1 Reimplement the countVowels function from the last lab using pipelines and functio composition 
This implementation should handle lowercase and uppercase vowels too.
Write at least two tests to check your implementation.

```elm
countVowels : String -> Int
countVowels string =
  let
    vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
    isVowel char = if List.member char vowels then 1 else 0
  in (String.toList string) |> List.map (\x -> isVowel x) |> List.foldl (+) 0
```

## 5.8.2 Write a function changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
which receives a list of accounts and returns a list of accounts where the preferredTheme
field is set to the Dark value.

```elm
type ThemeConfig = Light | Dark
type alias AccountConfiguration =
    { 
      preferredTheme: ThemeConfig, 
      subscribedToNewsletter: Bool, 
      twoFactorAuthOn: Bool
    }

changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
changePreferenceToDarkTheme l =  List.map (\x -> { x | preferredTheme = Dark }) l
```

I wrote the test in ExerciseTests.elm line 46.

## 5.8.3 Write a function usersWithPhoneNumbers : List User -> List String 
which receives a list of users and returns a list containing the email addresses the of users who have provided
a phone number.

```elm
usersWithPhoneNumbers : List User -> List String
usersWithPhoneNumbers list = (List.filter (\x -> x.details.phoneNumber /= Nothing) list) |> List.map (\x -> x.email)
```

The test is in ExerciseTests.elm at line 22.

