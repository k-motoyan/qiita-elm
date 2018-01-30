module Http.Request.Qiita exposing (getItems, getItem, getFollowees)

{-| This module provides Qiita API Http Request functions.

# Requests
@docs getItems, getItem, getFollowees

-}

import Time exposing (Time, second)
import Http exposing (Request, Error(..), request, emptyBody, expectJson)
import Http.HeaderUtil exposing (ContentType(..), contentTypeHeader)
import Entity.Qiita exposing (Item, User)
import Json.Qiita.Decoder exposing (decodeItems, decodeItem)


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


{-| Qiita API Request: GET /items/:item_id
-}
getItem : String -> Request Item
getItem itemId =
    Http.request
        { method = "GET"
        , headers = [ contentTypeHeader ApplicationJson ]
        , url = createUrl V2 ("items/" ++ itemId)
        , body = emptyBody
        , expect = expectJson decodeItem
        , timeout = Just timeOutValue
        , withCredentials = True
        }


{-| Qiita API Request: GET /users/:user_id/followees
-}
getFollowees : String -> Request (List User)
getFollowees userId =
    Http.request
        { method = "GET"
        , headers = [ contentTypeHeader ApplicationJson ]
        , url = createUrl V2 ("users/" ++ userId ++ "/followees")
        , body = emptyBody
        , expect = expectJson decodeUsers
        , timeout = Just timeOutValue
        , withCredentials = True
        }


-- Private


type Version
    = V2


timeOutValue : Time
timeOutValue = 10 * second


versionToString : Version -> String
versionToString version =
    case version of
        V2 -> "v2"


createUrl : Version -> String -> String
createUrl version path =
    "https://qiita.com/api/" ++ versionToString version ++ "/" ++ path
