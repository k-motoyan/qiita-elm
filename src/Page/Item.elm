module Page.Item exposing (Model, createModel, Msg(..), view)


import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (innerHtml)
import Route exposing (Slug, slugToString)
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
    = NoOp


-- View


view : Model -> Html msg
view model =
    div []
        [ h1 [ class "title is-2" ] [ text model.title ]
        , div [ class "content", innerHtml model.contents ] []
        ]
