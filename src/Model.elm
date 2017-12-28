module Model exposing (Model, PageState(..), initModel)


import Route exposing (Route(..))


type PageState
    = Found Route
    | NotFound


type alias Model =
    {  pageState: PageState
    }


initModel : Model
initModel =
    { pageState = Found Home
    }

