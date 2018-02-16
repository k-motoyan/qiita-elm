module Main exposing (..)

import Navigation exposing (Location)
import Route exposing (Route(..), parseLocation)
import Model exposing (Model, PageState(..), initModel)
import Update exposing (Msg(..), update)
import Html exposing (Html, div)
import Page.Home as HomePage
import Page.Item as ItemPage
import Page.User as UserPage
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
            layout <| routeToView route model

        NotFound ->
            layout NotFound.view



routeToView : Route -> Model -> Html Msg
routeToView route model =
    case route of
        Home ->
            HomePage.view model.homeModel |> Html.map UpdateHomePage

        Items _ ->
            case model.itemModel of
                Just itemModel ->
                    ItemPage.view itemModel |> Html.map UpdateItemPage
                Nothing ->
                    NotFound.view

        Users _ ->
            UserPage.view |> Html.map UpdateUserPage



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program ChangeLocation
        { init = init
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }
