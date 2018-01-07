module Http.Request.Qiita exposing (getItems)

{-| This module provides Qiita API Http Request functions.

# Requests
@docs getItems

-}

import Time exposing (Time, second)
import Http exposing (Request, Error(..), request, emptyBody, expectJson)
import Http.HeaderUtil exposing (ContentType(..), contentTypeHeader)
import Entity.Qiita exposing (Item)
import Json.Qiita.Decoder exposing (decodeItems)


-- Requests


{-| Qiita API Request: GET /items
-}
getItems : Request (List Item)
getItems =
    Http.request
        { method = "GET"
        , headers = [ contentTypeHeader ApplicationJson ]
        , url = createUrl V2 "items"
        , body = emptyBody
        , expect = expectJson decodeItems
        , timeout = Just timeOutValue
        , withCredentials = True
        }


-- Private


type Version
    = V2


basePath : String
basePath = "https://qiita.com/api/"


timeOutValue : Time
timeOutValue = 10 * second


versionToString : Version -> String
versionToString version =
    case version of
        V2 -> "v2"


createUrl : Version -> String -> String
createUrl version path =
    basePath ++ versionToString version ++ "/" ++ path
