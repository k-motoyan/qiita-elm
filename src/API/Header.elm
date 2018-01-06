module API.Header exposing
    ( ContentType(..)
    , contentTypeHeader
    )


import Http exposing (Header, header)


-- ContentType


type ContentType
    = ApplicationJson


contentTypeHeader : ContentType -> Header
contentTypeHeader contentType =
    header "Content-Type" (contentTypeToString contentType)


contentTypeToString : ContentType -> String
contentTypeToString contentType =
    case contentType of
        ApplicationJson ->
            "application/json"
