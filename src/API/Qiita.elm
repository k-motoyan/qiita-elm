module API.Qiita exposing (Version(..), createUrl)

{-| This module provides basic functions related to the use of Qiita API.

# Definition
@docs Version

# Utilities
@docs createUrl

-}

{-| API versions.
-}
type Version
    = V2


basePath : String
basePath = "https://qiita.com/api/"


versionToString : Version -> String
versionToString version =
    case version of
        V2 -> "v2"


{-| Create URL with api version and path.

Usage:

    >>> createUrl V2 "items"
    "https://qiita.com/api/v2/items"
-}
createUrl : Version -> String -> String
createUrl version path =
    basePath ++ versionToString version ++ "/" ++ path
