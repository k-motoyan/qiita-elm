module Views.Tabs exposing (view)

import Html exposing (Html, div, ul, li, a, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : List ({ title: String, isActive: Bool, msg: a }) -> Html a
view tabItems =
    div [ class "tabs is-centered" ]
        [ ul []
            <| List.map tabItemView tabItems
        ]


tabItemView : { title: String, isActive: Bool, msg: a } -> Html a
tabItemView tabItem =
    let
        class_ =
            if tabItem.isActive then
                "is-active"
            else
                ""
    in
        li []
            [ a [ class class_, onClick tabItem.msg ] [ text tabItem.title] ]
