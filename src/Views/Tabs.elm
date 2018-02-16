module Views.Tabs exposing (view)

import Html exposing (Html, div, ul, li, a, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : List ({ title: String, msg: a }) -> Html a
view tabItems =
    div [ class "tabs is-centered" ]
        [ ul []
            <| List.map tabItemView tabItems
        ]


tabItemView : { title: String, msg: a } -> Html a
tabItemView tabItem =
    li []
        [ a [ onClick tabItem.msg ] [ text tabItem.title] ]
