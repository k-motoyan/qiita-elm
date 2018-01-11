module Page.Home exposing (Model, initModel, Msg(..), update, view)


import Html exposing (Html, div, ul, li, h1, text)
import Html.Attributes exposing (class)
import Http
import Http.Request.Qiita exposing (getItems)
import Entity.Qiita exposing (Item)
import Views.LoadingIndicator as LoadingIndicator


-- Model


type alias Model =
    { isLoading: Bool
    , isError: Bool
    , items: Maybe (List Item)
    }


initModel : Model
initModel =
    { isLoading = False
    , isError = False
    , items = Nothing
    }


-- Update


type Msg
    = LoadItems
    | LoadItemsDone (Result Http.Error (List Item))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadItems ->
            getItems
                |> Http.send LoadItemsDone
                |> List.singleton
                |> (!) { model | isLoading = True, isError = False }

        LoadItemsDone result ->
            case result of
                Ok items ->
                    { model | isLoading = False, items = Just items } ! []
                Err err ->
                    { model | isLoading = False, isError = True } ! []


-- View


view : Model -> Html msg
view model =
    if model.isLoading then
        LoadingIndicator.view
    else
        div []
            [ h1 [ class "title is-5" ] [ text "Home" ]
            , listView model.items
            ]


listView : Maybe (List Item) -> Html msg
listView items =
    case items of
        Just items ->
            ul [] <| List.map (\item -> li [] [ text <| item.title ++ " - " ++ item.user.name ]) items
        Nothing ->
            div [] [ text "データが見つかりませんでした。" ]
