module Name exposing (Model, Msg, update, view, subscriptions, init)

import Html exposing (..)
import Html.Attributes exposing (class, type_, value, checked)
import Html.Events exposing (onInput, onCheck)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { user : User
    , setting : Setting
    }


type alias User =
    { email : String, password : String }


type alias Setting =
    { news : Bool }


type Msg
    = FormUser User
    | FormSetting Setting


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FormUser user ->
            ( { model | user = user }, Cmd.none )

        FormSetting setting ->
            ( { model | setting = setting }, Cmd.none )


view : Model -> Html Msg
view { user, setting } =
    form []
        [ input [ type_ "text", value user.email, onInput (\str -> FormUser { user | email = str }) ] []
        , input [ type_ "text", value user.password, onInput (\str -> FormUser { user | password = str }) ] []
        , input [ type_ "checkbox", checked setting.news, onCheck (\bool -> FormSetting { setting | news = bool }) ] []
        , div [] [ text user.email ]
        , div [] [ text user.password ]
        , div [] [ text (toString setting.news) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { user = User "user" "password"
      , setting = Setting False
      }
    , Cmd.none
    )



-- potential reusable form
-- textInput : (m, r, f) -> List (Attribute msg) -> List (Html msg) -> Html msg
-- textInput (toMsg, record, frecord) attrs children =
--     input [ type_ "text", value (frecord record), onInput (\str -> toMsg { record | ?? = str }) ] []
