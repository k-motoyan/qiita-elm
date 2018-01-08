module Page.Home exposing (Model, initModel, view)


import Html exposing (Html, h1, text)
import Entity.Qiita exposing (Item)


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
    h1 [] [ text "Home" ]
