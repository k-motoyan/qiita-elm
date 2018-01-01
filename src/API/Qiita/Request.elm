module API.Qiita.Request exposing (getItems)


import Http exposing (Request, Error(..), request, emptyBody, expectString)
import API.Qiita exposing (Version(..), createUrl)


-- Get /items


getItems : Request String
getItems =
    Http.request
        { method = "GET"
        , headers = []
        , url = createUrl V2 "items"
        , body = emptyBody
        , expect = expectString
        , timeout = Nothing
        , withCredentials = True
        }
