module Views.Layout exposing (layout)


import Html exposing (Html, section, h1, div, text, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Route exposing (Route(Home))
import Model exposing (PageState(Found))
import Update exposing (Msg(TransitionPage))


layout : Html Msg -> Html Msg
layout html =
    div []
        [ section [ class "hero is-success" ]
            [ div [ class "hero-body" ]
                [ div [ class "container" ]
                    [ h1 [ class "title" ]
                        [ a [ onClick <| TransitionPage (Found Home) ] [ text "Qiita Client" ] ]
                    ]
                ]
            ]
        , section [ class "section" ]
            [ div [ class "container"] [ html] ]
        ]
