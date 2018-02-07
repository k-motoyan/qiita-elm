module Views.Tabs exposing (view, TabItem)

import Html exposing (Html, div, ul, li, a, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Update exposing (Msg)


type alias TabItem =
    { title: String
    , msg: Msg
    }


view : List (TabItem) -> Html Msg
view tabItems =
    div [ class "tabs is-centered" ]
        [ ul []
            <| List.map tabItemView tabItems
        ]


tabItemView : TabItem -> Html Msg
tabItemView tabItem =
    li []
        [ a [ onClick tabItem.msg ] [ text tabItem.title] ]
