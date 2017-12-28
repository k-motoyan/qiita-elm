module Main exposing (..)

import Navigation exposing (Location, newUrl)
import Route exposing (Route(..), parseLocation, routeToPathStr)
import Html exposing (Html, div)
import Page.Home as Home
import Views.NotFound as NotFound


type PageState
    = Ok Route
    | NotFound


---- MODEL ----


type alias Model =
    {  pageState: PageState
    }


init : Location -> (Model, Cmd Msg)
init location =
    let
        pageState = location
                    |> parseLocation
                    |> Maybe.andThen (\route -> Just(Ok route))
                    |> Maybe.withDefault NotFound

        model = { initModel | pageState = pageState }
    in
        update (TransitionPage pageState) model


initModel : Model
initModel =
    { pageState = Ok Home
    }


---- UPDATE ----


type Msg
    = ChangeLocation Location
    | TransitionPage PageState


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeLocation location ->
            case parseLocation location of
                Just route ->
                    { model | pageState = Ok route } ! []
                Nothing ->
                    { model | pageState = NotFound } ! []

        TransitionPage pageState ->
            { model | pageState = pageState } ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.pageState of
        Ok route ->
            routeToView route

        NotFound ->
            NotFound.view



routeToView : Route -> Html Msg
routeToView route =
    case route of
        Home ->
            Home.view



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program ChangeLocation
        { init = init
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }
