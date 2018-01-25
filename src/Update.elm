module Update exposing (Msg(..), update)


import Task exposing (succeed, perform)
import Tuple exposing (mapFirst, mapSecond)
import Basics.Extra exposing ((=>))
import Navigation exposing (Location, newUrl)
import Model exposing (Model, PageState(..))
import Route exposing (Route(..), parseLocation, routeToPathStr, slugToString)
import Page.Home as HomePage
import Page.Item as ItemPage


type Msg
    = ChangeLocation Location
    | TransitionPage PageState
    | UpdateHomePage HomePage.Msg
    | UpdateItemPage ItemPage.Msg


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
                        |> (=>) model
                NotFound ->
                    { model | pageState = pageState } ! []

        UpdateHomePage msg ->
            case msg of
                HomePage.Transit route ->
                    transitPage route model
                _ ->
                    HomePage.update msg model.homeModel
                        |> mapFirst
                            (\model_ -> { model | homeModel = model_ })
                        |> mapSecond
                            (\msg_ -> Cmd.map (\a -> UpdateHomePage a) msg_)

        UpdateItemPage msg ->
            case model.itemModel of
                Just itemModel ->
                    ItemPage.update msg itemModel
                        |> mapFirst
                            (\model_ -> { model | itemModel = Just model_ })
                        |> mapSecond
                            (\msg_ -> Cmd.map (\a -> UpdateItemPage a) msg_)
                Nothing ->
                    model ! []


-- Private


initRoute : Route -> Model -> (Model, Cmd Msg)
initRoute route model =
    case route of
        Home ->
            succeed HomePage.LoadItems
                |> perform (\msg -> UpdateHomePage msg)
                |> (=>) model

        Items slug ->
            case model.homeModel.items of
                Just items ->
                    { model | itemModel = ItemPage.createModel slug items } ! []
                Nothing ->
                    model ! []


transitPage : Route -> Model -> (Model, Cmd Msg)
transitPage route model =
    succeed (Found route)
        |> perform (\page -> TransitionPage page)
        |> (=>) model
