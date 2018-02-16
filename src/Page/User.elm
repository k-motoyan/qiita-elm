module Page.User exposing (Model, initModel, Msg(..), view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Route exposing (Route(..))
import Entity.Qiita exposing (User, StockItem)
import Views.Tabs as Tabs
import Views.LoadingIndicator as LoadingIndicator


-- Model


type alias Model =
    { my: User
    , stockItems: Maybe (List StockItem)
    , followers: Maybe (List User)
    , followees: Maybe (List User)
    }


initModel : User -> Model
initModel user =
    { my = user
    , stockItems = Nothing
    , followers = Nothing
    , followees = Nothing
    }


-- Update


type Msg
    = Transit Route


-- View


view : Html Msg
view =
    div []
        [ Tabs.view tabItems
        , div [ class "contents" ]
            [ LoadingIndicator.view ]
        ]


type Tab
    = Stocks
    | Posts
    | Follow


tabItems : List ({ title: String, msg: Msg })
tabItems =
    [ { title = Stocks |> tabToTitle
      , msg = Stocks |> tabToRoute |> Transit
      }
    , { title = Posts |> tabToTitle
      , msg = Posts |> tabToRoute |> Transit
      }
    , { title = Follow |> tabToTitle
      , msg = Follow |> tabToRoute |> Transit
      }
    ]


tabToTitle : Tab -> String
tabToTitle tab =
    case tab of
        Stocks ->
            "ストックした投稿"

        Posts ->
            "自分の投稿"

        Follow ->
            "フォロワー／フォロイー"


tabToRoute : Tab -> Route
tabToRoute tab =
    case tab of
        Stocks ->
            Home

        Posts ->
            Home

        Follow ->
            Home
