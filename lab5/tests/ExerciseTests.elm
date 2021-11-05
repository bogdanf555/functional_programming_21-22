
module ExerciseTests exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)

import Exercises exposing (..)
import Theme

suite : Test
suite = 
  describe "Exercises module"
    [ describe "Exercises.usersWithPhoneNumbers"
      [ test "First example" <| 
          \_ -> 
            let 
              user1 = makeUser "john00" "johndoe@gmail.com" "John" "Doe" (Just "0123456789")
              user2 = makeUser "jane12" "jane12@yahoo.com" "Jane" "Doe" Nothing
              user3 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "345870481")
            in
              Expect.equal [user1.email, user3.email] <| usersWithPhoneNumbers [user1, user2, user3]
      , test "Second test" <| 
          \_ -> 
            let 
              user1 = makeUser "john00" "johndoe@gmail.com" "John" "Doe" (Just "0123456789")
              user2 = makeUser "jane12" "jane12@yahoo.com" "Jane" "Doe" Nothing
              user3 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "453543")
              user12 = makeUser "john001" "johndoe@gmail.comtest" "John1" "Doe1" (Just "01254353456789")
              user23 = makeUser "jane122" "jane12@yahoo.comone" "Jane1" "Doe1" Nothing
              user34 = makeUser "jacob143" "jacobh@yahoo.comtwo" "Jacob1" "Hunt1" (Just "345870483241")
            in
              Expect.equal [user1.email, user3.email, user12.email, user34.email] 
                <| usersWithPhoneNumbers [user1, user2, user3, user12, user23, user34]

      ]
    , describe "Exercises.changePreferenceToDarkTheme"
      [ test "First example" <| 
          \_ -> 
            let 
              config1 = AccountConfiguration Theme.Light True False
              config1Dark = AccountConfiguration Theme.Dark True False
              config2 = AccountConfiguration Theme.Dark False False
              config3 = AccountConfiguration Theme.Dark False True
            in
              Expect.equal [config1Dark, config2, config3] <| changePreferenceToDarkTheme [config1, config2, config3]
      , test "Second test" <| 
          \_ -> 
            let 
              config1 = AccountConfiguration Theme.Light True False
              config1Dark = AccountConfiguration Theme.Dark True False
              config2 = AccountConfiguration Theme.Light False False
              config2Dark = AccountConfiguration Theme.Dark False False
              config3 = AccountConfiguration Theme.Light False True
              config3Dark = AccountConfiguration Theme.Dark False True
            in
              Expect.equal [config1Dark, config2Dark, config3Dark] <| changePreferenceToDarkTheme [config1, config2, config3]
      ]
    ]

