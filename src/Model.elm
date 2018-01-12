module Model exposing (Model, PageState(..), initModel)


import Route exposing (Route(..))
import Page.Home as HomePage
import Page.Item as ItemPage


type PageState
    = Found Route
    | NotFound


type alias Model =
    { pageState: PageState
    , homeModel: HomePage.Model
    , itemModel: Maybe ItemPage.Model
    }


initModel : Model
initModel =
    { pageState = Found Home
    , homeModel = HomePage.initModel
    , itemModel = Nothing
    }

