module Page.Home exposing (Model, initModel, Msg(..), update, view)


import Html exposing (Html, div, ul, li, a, h1, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Http
import Http.Request.Qiita exposing (getItems)
import Route exposing (Route(..), Slug(..))
import Entity.Qiita exposing (Item)
import Views.LoadingIndicator as LoadingIndicator


-- Model


type alias Model =
    { isLoading: Bool
    , isError: Bool
    , items: Maybe (List Item)
    , title: String
    }


initModel : Model
initModel =
    { isLoading = False
    , isError = False
    , items = Nothing
    , title = "Home"
    }


-- Update


type Msg
    = LoadItems
    | LoadItemsDone (Result Http.Error (List Item))
    | Transit Route


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

        Transit route ->
            (model, Cmd.none)


-- View


view : Model -> Html Msg
view model =
    if model.isLoading then
        LoadingIndicator.view
    else
        div []
            [ h1 [ class "title is-5" ] [ text model.title ]
            , listView model.items
            ]


listView : Maybe (List Item) -> Html Msg
listView items =
    case items of
        Just items ->
            items
                |> List.map (\item -> listItemView item)
                |> ul []
        Nothing ->
            div [] [ text "データが見つかりませんでした。" ]


listItemView : Item -> Html Msg
listItemView item =
    let
        slug = Slug item.id
    in
        li []
            [ a [ onClick <| Transit (Items slug) ]
                [ text item.title ]
            ]
