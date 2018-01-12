module Route exposing
    ( Route(..)
    , Slug(..)
    , parseLocation
    , routeToPathStr
    , slugToString
    )


import Navigation exposing
    ( Location
    )
import UrlParser exposing
    ( Parser
    , parsePath
    , custom
    , map
    , top
    , s
    , (</>)
    )


type Route
    = Home
    | Items Slug


type Slug
    = Slug String


slugToString : Slug -> String
slugToString (Slug slug) =
    slug


parseLocation : Location -> Maybe Route
parseLocation location =
    parsePath matchers location


routeToPathStr : Route -> String
routeToPathStr route =
    case route of
        Home ->
            "/"
        Items slug ->
            "/items/" ++ (slugToString slug)


-- Private


matchers : Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ map Home top
        , map Home (s "/")
        , map Items (s "items" </> slugParser)
        ]


slugParser : Parser (Slug -> a) a
slugParser =
    custom "SLUG" (Ok << Slug)
