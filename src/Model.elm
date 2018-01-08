module Model exposing (Model, PageState(..), initModel)


import Route exposing (Route(..))
import Page.Home as Home


type PageState
    = Found Route
    | NotFound


type alias Model =
    { pageState: PageState
    , homeModel: Home.Model
    }


initModel : Model
initModel =
    { pageState = Found Home
    , homeModel = Home.initModel
    }

