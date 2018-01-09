module Page.Home exposing (Model, initModel, view)


import Html exposing (Html, h1, text)
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


-- View


view : Model -> Html msg
view model =
    if model.isLoading then
        LoadingIndicator.view
    else
        h1 [] [ text "Home" ]
