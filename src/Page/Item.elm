module Page.Item exposing (Model, createModel, Msg(..), update, view)


import Basics.Extra exposing ((=>), swap)
import Http
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (innerHtml)
import Route exposing (Slug, slugToString)
import Http.Request.Qiita exposing (getItem)
import Entity.Qiita exposing (Item)


-- Model


type alias Model =
    { isLoading: Bool
    , isError: Bool
    , title: String
    , contents: String
    }


createModel : Slug -> (List Item) -> Maybe Model
createModel slug items =
    items
        |> List.filter (\item -> item.id == slugToString slug)
        |> List.head
        |> Maybe.map (updateContents defaultModel)


updateContents : Model -> Item -> Model
updateContents model item =
    { model | title = item.title, contents = item.rendered_body }


defaultModel : Model
defaultModel =
    { isLoading = False
    , isError = False
    , title = ""
    , contents = ""
    }


-- Update


type Msg
    = LoadItem String
    | LoadItemDone (Result Http.Error Item)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadItem id ->
            getItem id
                |> Http.send LoadItemDone
                |> (=>) { model | isLoading = True, isError = False }

        LoadItemDone result ->
            let
                newModel = { model | isLoading = False, isError = True }
            in
                case result of
                    Ok item ->
                        item
                            |> updateContents newModel
                            |> (=>) Cmd.none
                            |> swap
                    Err err ->
                        newModel ! []


-- View


view : Model -> Html msg
view model =
    div []
        [ h1 [ class "title is-2" ] [ text model.title ]
        , div [ class "content", innerHtml model.contents ] []
        ]
