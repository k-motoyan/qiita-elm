module Update exposing (Msg(..), update)


import Task exposing (succeed, perform)
import Tuple exposing (mapFirst, mapSecond)
import Navigation exposing (Location, newUrl)
import Model exposing (Model, PageState(..))
import Route exposing (Route(..), parseLocation, routeToPathStr)
import Page.Home as Home


type Msg
    = ChangeLocation Location
    | TransitionPage PageState
    | UpdateHome Home.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeLocation location ->
            case parseLocation location of
                Just route ->
                    initRoute route { model | pageState = Found route }
                Nothing ->
                    { model | pageState = NotFound } ! []

        TransitionPage pageState ->
            case pageState of
                Found route ->
                    routeToPathStr route
                        |> newUrl
                        |> List.singleton
                        |> (!) model

                NotFound ->
                    { model | pageState = pageState } ! []

        UpdateHome msg ->
            Home.update msg model.homeModel
                |> mapFirst (\model_ -> { model | homeModel = model_ })
                |> mapSecond (\msg_ -> Cmd.map (\a -> UpdateHome a) msg_)


initRoute : Route -> Model -> (Model, Cmd Msg)
initRoute route model =
    case route of
        Home ->
            succeed Home.LoadItems
                |> perform (\msg -> UpdateHome msg)
                |> List.singleton
                |> (!) model
