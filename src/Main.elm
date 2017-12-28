module Main exposing (..)

import Navigation exposing (Location)
import Route exposing (Route(..), parseLocation)
import Model exposing (Model, PageState(..), initModel)
import Update exposing (Msg(..), update)
import Html exposing (Html, div)
import Page.Home as Home
import Views.Layout exposing (layout)
import Views.NotFound as NotFound


init : Location -> (Model, Cmd Msg)
init location =
    let
        pageState = location
                    |> parseLocation
                    |> Maybe.andThen (\route -> Just(Found route))
                    |> Maybe.withDefault NotFound

        model = { initModel | pageState = pageState }
    in
        update (TransitionPage pageState) model


---- VIEW ----


view : Model -> Html Msg
view model =
    case model.pageState of
        Found route ->
            layout <| routeToView route

        NotFound ->
            layout NotFound.view



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
