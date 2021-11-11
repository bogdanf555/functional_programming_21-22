
module CoinFlip exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type CoinSide
  = Heads
  | Tails

type alias Model =
  { currentFlip : Maybe CoinSide
  , flips: List CoinSide
  , headFlips: Int
  , tailFlips: Int
  }

initModel = Model Nothing [] 0 0 

init : () -> (Model, Cmd Msg)
init _ =
  ( initModel
  , Random.generate AddFlip coinFlip
  )

type Msg
  = Flip
  | AddFlip CoinSide | FlipMultiple Int

incrementIf: Model -> CoinSide -> Int
incrementIf model coinSide = 
  case coinSide of
    Heads -> if model.currentFlip == (Just Heads) then model.headFlips + 1 else model.headFlips
    Tails -> if model.currentFlip == (Just Tails) then model.tailFlips + 1 else model.tailFlips

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip ->
      ( model
      , Random.generate AddFlip coinFlip
      )

    FlipMultiple times ->
      (
        model
      , Cmd.batch (List.map (\x -> Random.generate AddFlip coinFlip) (List.range 1 times))
      )

    AddFlip coin ->
      ( Model (Just coin) (coin::model.flips) (incrementIf model Heads) (incrementIf model Tails)
      , Cmd.none
      )

coinFlip : Random.Generator CoinSide
coinFlip =
  Random.uniform Heads
    [ Tails ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  let
    currentFlip = 
      model.currentFlip 
      |> Maybe.map viewCoin
      |> Maybe.withDefault (text "Press the flip button to get started")
    flips = 
      model.flips 
      |> List.map coinToString
      |> List.intersperse " "
      |> List.map text
  in
    div []
      [ button [ onClick Flip ] [ text "Flip" ]
      , button [ onClick (FlipMultiple 10)] [ text "Flip 10" ]
      , button [ onClick (FlipMultiple 100)] [ text "Flip 100" ]
      , currentFlip
      , div [] flips
      , div [] 
        [
          p [] [text ("heads from variable: " ++ String.fromInt model.headFlips)]
        , p [] [text ("tails from variable: " ++ String.fromInt model.tailFlips)] 
        , p [] [text ("heads computed: " ++ String.fromInt (List.foldl (\b a -> if b == Heads then a + 1 else a) 0 model.flips))]
        , p [] [text ("tails computed: " ++ String.fromInt (List.foldl (\b a -> if b == Tails then a + 1 else a) 0 model.flips))]  
        ]
      ]

coinToString : CoinSide -> String
coinToString coin =
  case coin of
    Heads -> "h"
    Tails -> "t"

viewCoin : CoinSide -> Html Msg
viewCoin coin =
  let
    name = coinToString coin
  in
    div [ style "font-size" "4em" ] [ text name ]

