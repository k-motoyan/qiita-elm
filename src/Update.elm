module Update exposing (Msg(..), update)


import Task exposing (succeed, perform)
import Tuple exposing (mapFirst, mapSecond)
import Basics.Extra exposing ((=>))
import Navigation exposing (Location, newUrl)
import Model exposing (Model, PageState(..))
import Route exposing (Route(..), parseLocation, routeToPathStr, slugToString)
import Entity.Qiita exposing (Item, User)
import Page.Home as HomePage
import Page.Item as ItemPage
import Page.User as UserPage


type Msg
    = ChangeLocation Location
    | TransitionPage PageState
    | UpdateHomePage HomePage.Msg
    | UpdateItemPage ItemPage.Msg
    | UpdateUserPage UserPage.Msg


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
            let
                newModel =
                    model.itemModel
                        |> Maybe.withDefault ItemPage.defaultModel
            in
                ItemPage.update msg newModel
                    |> mapFirst
                        (\model_ -> { model | itemModel = Just model_ })
                    |> mapSecond
                        (\msg_ -> Cmd.map (\a -> UpdateItemPage a) msg_)

        UpdateUserPage msg ->
            (model, Cmd.none)

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
                    let
                        id = slugToString slug
                    in
                        succeed (ItemPage.LoadItem id)
                            |> perform (\msg -> UpdateItemPage msg)
                            |> (=>) model

        Users userID ->
            case model.userModel of
                Just userModel ->
                    { model | userModel = Just userModel } => Cmd.none
                Nothing ->
                    model => Cmd.none


transitPage : Route -> Model -> (Model, Cmd Msg)
transitPage route model =
    succeed (Found route)
        |> perform (\page -> TransitionPage page)
        |> (=>) model


selectUserFromItems : List (Item) -> String -> Maybe User
selectUserFromItems items userID =
    let
        isSameUser = \item ->
            if item.user.id == userID then
                Just item.user
            else
                Nothing
    in
        items
            |> List.filterMap isSameUser
            |> List.head
