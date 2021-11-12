
module Countries exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, placeholder, style, type_, value, disabled)
import Html.Events exposing (..)
import Http
import Json.Decode as Dec


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Country =
    { name : String
    , area : Float
    , population : Int
    , region : String
    }


decodeCountry : Dec.Decoder Country
decodeCountry =
    Dec.map4 Country 
        (Dec.at  ["name", "common"] Dec.string)
        (Dec.field "area" Dec.float)
        (Dec.field "population" Dec.int)
        (Dec.field "region" Dec.string)

type Model
    = Initial
    | RequestSent
    | Success ({countries: List Country, sorting: String}) 
    | Error Http.Error

init : () -> ( Model, Cmd Msg )
init _ =
    ( Initial
    , Cmd.none
    )


type Msg
    = GetCountries
    | GotCountries (Result Http.Error (List Country))
    | ChangeSorting Bool

getCountries : Cmd Msg
getCountries = Http.get 
    { url = "https://restcountries.com/v3.1/all"
    , expect = Http.expectJson GotCountries (Dec.list decodeCountry) 
    }

changeSorting : String -> String
changeSorting sorting = 
    if sorting == "ascending" then
        "descending"
    else 
        "ascending"

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCountries ->
            ( RequestSent
            , getCountries
            )

        GotCountries (Ok countries) ->
            ( Success {countries=countries, sorting="descending"}
            , Cmd.none
            )

        GotCountries (Err err) ->
            ( Error err
            , Cmd.none
            )
        ChangeSorting value ->
            case model of
              Success {countries, sorting} -> 
                ( Success {countries=countries, sorting=(changeSorting sorting)}
                , Cmd.none
                )
              _ ->
                ( model
                , Cmd.none
                )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    case model of
        Initial ->
            viewInitial

        RequestSent ->
            div [] [ text "Loading..." ]

        Success {countries, sorting} ->
            div [] [
                div [] 
                [   input [ type_ "checkbox", onCheck ChangeSorting] []
                    , text "Sort Ascending?"
                ]
                , viewSuccess countries sorting
            ]

        Error err ->
            viewError err

viewInitial : Html Msg
viewInitial =
    div []
        [ button [ onClick GetCountries ] [ text "Get countries" ]
        ]

viewCountry : Country -> Html msg
viewCountry {name, area, population, region} =
    div [style "border" "solid 1px", style "margin" "2px"] 
        [ p [] [text <| "Name:" ++ name]
        , p [] [text <| "Area: " ++ String.fromFloat area]
        , p [] [text <| "Population: " ++ String.fromInt population]
        , p [] [text <| "Population density: " ++ String.fromFloat (toFloat population / area)]
        ]


countryComparison sorting a b =
    if sorting == "descending" then
        case compare a.area b.area of
        LT -> GT
        EQ -> EQ
        GT -> LT
    else
        case compare a.area b.area of
        LT -> LT
        EQ -> EQ
        GT -> GT

viewSuccess : List Country -> String -> Html msg
viewSuccess countries sorting =
    div [] ((h2 [] [ text "ok" ])::List.map viewCountry (List.sortWith (countryComparison sorting) countries))


httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        Http.BadUrl _ ->
            "Bad Url"

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus status ->
            "BadS tatus: " ++ String.fromInt status

        Http.BadBody _ ->
            "Bad Body"


viewError : Http.Error -> Html msg
viewError err =
    div [] [ h2 [] [ text "Rip" ], p [] [ text <| httpErrorToString err ] ]


    

