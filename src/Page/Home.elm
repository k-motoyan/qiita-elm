module Page.Home exposing (Model, initModel, Msg(..), update, view)


import Basics.Extra exposing ((=>))
import Html exposing (..)
import Html.Attributes exposing (class, style, src, alt, href)
import Html.Events exposing (onClick)
import Color exposing (red, darkGrey)
import Http
import Http.Request.Qiita exposing (getItems)
import Route exposing (Route(..), Slug(..))
import Entity.Qiita exposing (Item, User)
import Views.LoadingIndicator as LoadingIndicator
import Material.Icons.Action as ActionIcon
import Material.Icons.Communication as CommunicationIcon


-- Model


type alias Model =
    { isLoading: Bool
    , isError: Bool
    , items: Maybe (List Item)
    , title: String
    }


initModel : Model
initModel =
    { isLoading = False
    , isError = False
    , items = Nothing
    , title = "Home"
    }


-- Update


type Msg
    = LoadItems
    | LoadItemsDone (Result Http.Error (List Item))
    | Transit Route


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadItems ->
            getItems
                |> Http.send LoadItemsDone
                |> (=>) { model | isLoading = True, isError = False }

        LoadItemsDone result ->
            case result of
                Ok items ->
                    { model | isLoading = False, items = Just items } ! []
                Err err ->
                    { model | isLoading = False, isError = True } ! []

        Transit route ->
            (model, Cmd.none)


-- View


view : Model -> Html Msg
view model =
    if model.isLoading then
        LoadingIndicator.view
    else
        div []
            [ listView model.items
            ]


listView : Maybe (List Item) -> Html Msg
listView items =
    case items of
        Just items ->
            items
                |> List.map (\item -> listItemView item)
                |> div []
        Nothing ->
            div [] [ text "データが見つかりませんでした。" ]


listItemView : Item -> Html Msg
listItemView item =
    let
        slug = Slug item.id
    in
        a [ class "box", onClick <| Transit (Items slug) ]
            [ article [ class "media"]
                [ div [ class "media-left"]
                    [ figure [ class "image is-64x64" ]
                        [ userImage item.user ]
                    ]
                , div [ class "media-content" ]
                    [ div [ class "content" ]
                        [ p []
                            [ strong [] [ text item.title ]
                            ]
                        ]
                    , nav [ class "level is-mobile" ]
                        [ div [ class "level-left"]
                            [ qiitaLikeIcon item
                            , qiitaCommentIcon item
                            ]
                        ]
                    ]
                ]
            ]


userImage : User -> Html msg
userImage user =
    img [ src user.profile_image_url, alt "image" ] []


iconSize : Int
iconSize = 18


iconStyle : Attribute msg
iconStyle =
    style
        [ ("margin-left", "4px")
        ]


countText : Int -> Html msg
countText count =
    text (count |> toString)


qiitaLikeIcon : Item -> Html msg
qiitaLikeIcon item =
    span [ class "level-item" ]
        [ ActionIcon.favorite_border red iconSize
        , span [ iconStyle ] [ countText item.likes_count ]
        ]


qiitaCommentIcon : Item -> Html msg
qiitaCommentIcon item =
    span [ class "level-item" ]
        [ CommunicationIcon.chat_bubble_outline darkGrey iconSize
        , span [ iconStyle ] [ countText item.reactions_count ]
        ]
