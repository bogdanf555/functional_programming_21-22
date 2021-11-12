
module Inputs exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, placeholder, style, type_, value, disabled)
import Html.Events exposing (..)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type AccountType
    = User
    | Admin


accountTypes : List AccountType
accountTypes = [User, Admin]

accountTypeToString ty =
    case ty of
        User ->
            "User"

        Admin ->
            "Admin"


accountTypeFromString s =
    case String.toLower s of
        "user" ->
            Just User

        "admin" ->
            Just Admin

        _ ->
            Nothing


type alias Model =
    { accountType : AccountType
    , activateAccount : Bool
    , username : String
    , password : String
    , confirmPassword : String
    , emailAddress : Maybe String
    }


type Msg
    = SelectedValue String
    | UsernameChanged String
    | PasswordChanged String
    | ConfirmPasswordChanged String
    | SetActivateAccount Bool

init : () -> ( Model, Cmd Msg )
init _ =
    ( { accountType = User, activateAccount = False, username = "", password = "", confirmPassword = "", emailAddress = Nothing }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectedValue s ->
            ( { model | accountType = accountTypeFromString s |> Maybe.withDefault User }
            , Cmd.none
            )

        UsernameChanged username ->
            ( { model | username = username }
            , Cmd.none
            )

        PasswordChanged password ->
            ( { model | password = password }
            , Cmd.none
            )

        ConfirmPasswordChanged confirmPassword ->
            ( { model | confirmPassword = confirmPassword }
            , Cmd.none
            )

        SetActivateAccount activate ->
            ( { model | activateAccount = activate }
            , Cmd.none
            )


accountTypeView : Html Msg
accountTypeView =
    div []
        [ select [ Html.Events.onInput SelectedValue ]
            [ option [ value "User" ] [ text "User" ]
            , option [ value "Admin" ] [ text "Admin" ]
            ]
        ]


accountDetailsView : Model -> Html Msg
accountDetailsView { username, password, confirmPassword } =
    let
        inputAttrs ty p v msg =
            [ type_ ty, placeholder p, value v, onInput msg ]
    in
    div []
        [ input (inputAttrs "text" "username" username UsernameChanged) []
        , input (inputAttrs "password" "password" password PasswordChanged) []
        , input (inputAttrs "password" "confirm password" confirmPassword ConfirmPasswordChanged) []
        ]


activateAccountView : Bool -> Html Msg
activateAccountView yes =
    div []
        [ input [ type_ "checkbox", onCheck SetActivateAccount, checked yes ] []
        , text "Activate account?"
        ]


statusView : Model -> Html Msg
statusView model =
    div []
        [ p [] [ text "Account type: ", text <| accountTypeToString model.accountType ]
        , p [] [ text "Username: ", text model.username ]
        , p [] [ text "Password: ", text model.password ]
        , p [] [ text "Confirm Password: ", text model.confirmPassword ]
        , p []
            [ text <|
                if model.activateAccount then
                    "Account will be created activated"

                else
                    "Account will be created suspended"
            ]
        ]

isNotComplete: Model -> Bool
isNotComplete model =
    if (String.isEmpty model.username) || (String.isEmpty model.password) || (model.password /= model.confirmPassword)
        || (model.accountType == Admin && (String.length model.password < 12)) 
        || (model.accountType == User && (String.length model.password < 8)) then
        True
    else
        False

conditions: Model -> {color : String, message : String}
conditions model =
    if model.password == "" then
        {color="red", message="Passwords empty!"}
    else if model.accountType == Admin && (String.length model.password < 12) then
        {color="red", message="Passwords must be at least 12 characters for admin!"}
    else if model.accountType == User && (String.length model.password < 8) then
        {color="red", message="Passwords must be at least 8 characters for user!"}
    else if model.password == model.confirmPassword then
        {color="green", message="Passwords match!"}
    else
        {color="red", message="Passwords don't match!"}

view : Model -> Html Msg
view model =
    let
        color c = style "color" c
        passwordMessage = conditions model
    in
    div []
        [ statusView model
        , accountTypeView
        , activateAccountView model.activateAccount
        , accountDetailsView model
        , p [color passwordMessage.color] [text passwordMessage.message]
        , button [disabled (isNotComplete model)] [text "Create account"]
        ]

