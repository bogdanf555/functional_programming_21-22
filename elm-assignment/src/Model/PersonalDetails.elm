module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }

viewContact: DetailWithName -> Html msg
viewContact d = 
    li [ class "contact-detail"] [ text (d.name ++ ": " ++ d.detail) ]

viewSocialMedia: DetailWithName -> Html msg
viewSocialMedia d = 
    li [] [ a [ href d.detail, class "contact-detail"] [ text d.name ] ]

view : PersonalDetails -> Html msg
view details =
    div [] [
        h1 [ id "name" ] [text details.name]
    ,   h2 [] [ text "Intro" ]
    ,   em [ id "intro" ] [text details.intro]
    ,   h2 [] [text "Contacts"] 
    ,   ul [ id "contacts" ] (List.map (\x -> viewContact x) details.contacts)
    ,   ul [ class "social-link" ] (List.map (\x -> viewSocialMedia x) details.socials)
    ]
    