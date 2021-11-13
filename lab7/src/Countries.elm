
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
    | Success ({countries: List Country, sorting: String, field: String}) 
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
    | SelectedValue String

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
            ( Success {countries=countries, sorting="descending", field="population"}
            , Cmd.none
            )

        GotCountries (Err err) ->
            ( Error err
            , Cmd.none
            )
        ChangeSorting value ->
            case model of
              Success {countries, sorting, field} -> 
                ( Success {countries=countries, sorting=(changeSorting sorting), field=field}
                , Cmd.none
                )
              _ ->
                ( model
                , Cmd.none
                )
        SelectedValue selectedField ->
            case model of
                Success {countries, sorting, field} -> 
                    ( Success {countries=countries, sorting=(changeSorting sorting), field=selectedField}
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

        Success {countries, sorting, field} ->
            div [] 
            [
                div [] 
                [   input [ type_ "checkbox", onCheck ChangeSorting] []
                    , text "Sort Ascending?"
                ]
                , div []
                [ select [ Html.Events.onInput SelectedValue ]
                    [ option [ value "population" ] [ text "population" ]
                    , option [ value "area" ] [ text  "area" ]
                    , option [ value "population_density" ] [text "population density" ]
                    ]
                ]
                , viewSuccess countries sorting field
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
        , p [] [text <| "Region: " ++ region ]
        , p [] [text <| "Population: " ++ String.fromInt population]
        , p [] [text <| "Population density: " ++ String.fromFloat (toFloat population / area)]
        ]


retrieveField: String -> Country -> Float
retrieveField field country =
    case field of
       "area" -> country.area
       "population_density" -> (toFloat country.population / country.area)
       _ -> toFloat country.population

countryComparison sorting field a b =
    let 
        field1 = retrieveField field a
        field2 = retrieveField field b
    in
    if sorting == "descending" then
        case compare field1 field2 of
            LT -> GT
            EQ -> EQ
            GT -> LT
    else
        case compare field1 field2 of
            LT -> LT
            EQ -> EQ
            GT -> GT

viewSuccess : List Country -> String -> String -> Html msg
viewSuccess countries sorting field =
    div [] ((h2 [] [ text "ok" ])::List.map viewCountry (List.sortWith (countryComparison sorting field) countries))


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


    

