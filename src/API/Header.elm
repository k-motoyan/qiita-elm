module API.Header exposing
    ( ContentType(..) , contentTypeHeader
    )

{-| This module provides Http request header utilities.

# Content-Type
@docs ContentType, contentTypeHeader

-}

import Http exposing (Header, header)


-- ContentType


{-| Content-Types.
-}
type ContentType
    = ApplicationJson


{-| Create content type header.

Usage:

    >>> contentTypeHeader ApplicationJson
    header "Content-Type" "application/json"
-}
contentTypeHeader : ContentType -> Header
contentTypeHeader contentType =
    header "Content-Type" (contentTypeToString contentType)


contentTypeToString : ContentType -> String
contentTypeToString contentType =
    case contentType of
        ApplicationJson ->
            "application/json"
