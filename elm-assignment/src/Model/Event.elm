module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"

compareByInterval a b =
    Interval.compare a.interval b.interval

sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith compareByInterval events


eventClass: Bool -> String
eventClass eventType =
    if eventType then "event event-important" else "event"

view : Event -> Html Never
view event =
    div [ class <| eventClass <| event.important ] [
        h2 [ class "event-title" ] [ text event.title ]
    ,   ul [] [
            li [ class "event-description" ] [ event.description ]
        ,   li [ class "event-category" ] [ categoryView event.category ]
        ,   div [class "event-interval" ] [ Interval.view event.interval ]
        ,   li [] [ a [ class "event-url", href <| Maybe.withDefault "" event.url] [ text "Event Link"]]
        ]
    ]
    
