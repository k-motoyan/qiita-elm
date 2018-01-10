module Update exposing (Msg(..), update)


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
                    { model | pageState = Found route } ! []
                Nothing ->
                    { model | pageState = NotFound } ! []

        TransitionPage pageState ->
            case pageState of
                Found route ->
                    routeToPathStr route
                        |> newUrl
                        |> List.singleton
                        |> (!) { model | pageState = pageState }

                NotFound ->
                    { model | pageState = pageState } ! []

        UpdateHome msg ->
            let
                (homeModel, homeCmd) = Home.update msg model.homeModel
            in
                homeCmd
                    |> Cmd.map (\a -> UpdateHome a)
                    |> List.singleton
                    |> (!) { model | homeModel = homeModel }
