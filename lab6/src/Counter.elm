
module Counter exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.Attributes exposing (disabled)

main =
  Browser.sandbox { init = 0, update = update, view = view }

type alias Model = Int

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

colorAttribute : Model -> Html.Attribute msg
colorAttribute model = 
  let
    greenColor = style "color" "green"
    redColor = style "color" "red"
  in
    if model < -8 || model > 8 then
      redColor
    else
      greenColor


view : Model -> Html Msg
view model =
  let
    bigFont = style "font-size" "20pt"
  in
    div []
      [ button [ disabled (model >= 10), bigFont, onClick Increment ] [ text "+" ]
      , div [ (colorAttribute model), bigFont ] [ text (String.fromInt model) ]
      , button [  disabled (model <= -10) ,bigFont, onClick Decrement ] [ text "-" ]
      ]

