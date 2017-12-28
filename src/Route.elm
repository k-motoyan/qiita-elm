module Route exposing
    ( Route(..)
    , parseLocation
    , routeToPathStr
    )


import Navigation exposing
    ( Location
    )
import UrlParser exposing
    ( Parser
    , parsePath
    , map
    , top
    , s
    )


type Route
    = Home


parseLocation : Location -> Maybe Route
parseLocation location =
    parsePath matchers location


routeToPathStr : Route -> String
routeToPathStr route =
    case route of
        Home ->
            "/"


-- Private


matchers : Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ map Home top
        , map Home
            <| s (routeToPathStr Home)
        ]
