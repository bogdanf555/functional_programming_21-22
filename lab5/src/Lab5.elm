module Lab5 exposing (..)

-- 5.2.2
all : (a -> Bool) -> List a -> Bool
all pred l = List.foldl (\a b -> a && b ) True <| (List.map (\x -> pred x) l)

any : (a -> Bool) -> List a -> Bool
any pred l = List.foldl (\a b -> a || b ) False <| (List.map (\x -> pred x) l)

-- 5.8.1
countVowels : String -> Int
countVowels string =
  let
    vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
    isVowel char = if List.member char vowels then 1 else 0
  in (String.toList string) |> List.map (\x -> isVowel x) |> List.foldl (+) 0

-- 5.8.2
type ThemeConfig = Light | Dark
type alias AccountConfiguration =
    { 
      preferredTheme: ThemeConfig, 
      subscribedToNewsletter: Bool, 
      twoFactorAuthOn: Bool
    }
changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
changePreferenceToDarkTheme l =  List.map (\x -> { x | preferredTheme = Dark }) l

-- 5.5.1
map2: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
map2 f ma mb =
  case (ma, mb) of
    (Nothing, _) -> Nothing
    (_, Nothing) -> Nothing
    (Just a, Just b) -> Just (f a b)

-- 5.8.3

type alias UserDetails =
   { firstName: String, lastName: String, phoneNumber: Maybe String}
type alias User = {id: String, email: String, details: UserDetails}

usersWithPhoneNumbers : List User -> List String
usersWithPhoneNumbers list = (List.filter (\x -> x.details.phoneNumber /= Nothing) list) |> List.map (\x -> x.email)