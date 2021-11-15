module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = SelectedEventCategories { academic: Bool, work: Bool, project: Bool, award: Bool }


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    SelectedEventCategories { academic=True, work=True, project=True, award=True }


{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    case (category, current) of
       (Academic, SelectedEventCategories record) -> record.academic
       (Work, SelectedEventCategories record) -> record.work
       (Project, SelectedEventCategories record) -> record.project
       (Award, SelectedEventCategories record) -> record.award


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    case (category, current) of
       (Academic, SelectedEventCategories record) -> SelectedEventCategories { record | academic=value }
       (Work, SelectedEventCategories record) -> SelectedEventCategories { record | work=value }
       (Project, SelectedEventCategories record) -> SelectedEventCategories { record | project=value }
       (Award, SelectedEventCategories record) -> SelectedEventCategories { record | award=value }


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view (SelectedEventCategories record) =
    let
        eventCategoryInfo = [("Academic", Academic, record.academic), 
            ("Work", Work, record.work), ("Project", Project, record.project), ("Award", Award, record.award)]
    in
        div [] <| List.map (\(x,y,z) -> checkbox x z y) eventCategoryInfo
                
