module Page.User exposing (view)

import Html exposing (Html, div, text)
import Route exposing (Route(..))
import Model exposing (PageState(Found))
import Update exposing (Msg(..))
import Views.Tabs as Tabs exposing (TabItem)


tabItems : List (TabItem)
tabItems =
    [ { title = "TODO1", msg = TransitionPage (Found Home) }
    , { title = "TODO2", msg = TransitionPage (Found Home) }
    , { title = "TODO3", msg = TransitionPage (Found Home) }
    ]


view : Html Msg
view =
    div [] [ Tabs.view tabItems ]
