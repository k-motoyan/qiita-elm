module Page.User exposing (Model, view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Route exposing (Route(..))
import Model exposing (PageState(Found))
import Update exposing (Msg(..))
import Entity.Qiita exposing (User, StockItem)
import Views.Tabs as Tabs exposing (TabItem)
import Views.LoadingIndicator as LoadingIndicator


-- Model


type alias Model =
    { my: User
    , stockItems: Maybe (List StockItem)
    , followers: Maybe (List User)
    , followees: Maybe (List User)
    }


-- View


tabItems : List (TabItem)
tabItems =
    [ { title = "ストックした投稿", msg = TransitionPage (Found Home) }
    , { title = "自分の投稿", msg = TransitionPage (Found Home) }
    , { title = "フォロワー／フォロイー", msg = TransitionPage (Found Home) }
    ]


view : Html Msg
view =
    div []
        [ Tabs.view tabItems
        , div [ class "contents" ]
            [ LoadingIndicator.view ]
        ]
