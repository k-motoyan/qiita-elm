module Views.Layout exposing (view)


import Html exposing (Html, h1, div, text)


view : Html msg
view =
    div []
        [ h1 [] [ text "Qiita Elm" ]
        ]
