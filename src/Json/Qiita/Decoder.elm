module Json.Qiita.Decoder exposing (decodeUser, decodeItems)

{-| This module provides Qiita JSON resource of decoder.

# Decoders
@docs decodeUser, decodeItems

-}

import Json.Decode exposing (Decoder, list, int, string, bool)
import Json.Decode.Extra exposing (date)
import Json.Decode.Pipeline exposing (decode, required)
import Entity.Qiita exposing (User, ItemTag, Item)


{-| Qiita user object decoder.

Usage:

    >>> import Date
    >>>
    >>> Json.Decode.decodeString
    >>>     decodeUser
    >>>     """
    >>>         {
    >>>             "description": "a",
    >>>             "facebook_id": "b",
    >>>             "followees_count": 0,
    >>>             "followers_count": 1,
    >>>             "github_login_name": "c",
    >>>             "id": "d",
    >>>             "items_count": 2,
    >>>             "linkedin_id": "e",
    >>>             "location": "f",
    >>>             "name": "g",
    >>>             "organization": "h",
    >>>             "permanent_id": 3,
    >>>             "profile_image_url": "i",
    >>>             "twitter_screen_name": "j",
    >>>             "website_url": "k"
    >>>         }
    >>>     """
    Result.Ok
        { description = "a"
        , facebook_id = "b"
        , followees_count = 0
        , followers_count = 1
        , github_login_name = "c"
        , id = "d"
        , items_count = 2
        , linkedin_id = "e"
        , location = "f"
        , name = "g"
        , organization = "h"
        , permanent_id = 3
        , profile_image_url = "i"
        , twitter_screen_name = "j"
        , website_url = "k"
        }
-}
decodeUser : Decoder User
decodeUser =
    decode User
        |> required "description" string
        |> required "facebook_id" string
        |> required "followees_count" int
        |> required "followers_count" int
        |> required "github_login_name" string
        |> required "id" string
        |> required "items_count" int
        |> required "linkedin_id" string
        |> required "location" string
        |> required "name" string
        |> required "organization" string
        |> required "permanent_id" int
        |> required "profile_image_url" string
        |> required "twitter_screen_name" string
        |> required "website_url" string


{-| Qiita items object decoder.

Usage:

    >>> Json.Decode.decodeString
    >>>     decodeItems
    >>>     """
    >>>         [
    >>>             {
    >>>                 "rendered_body": "<h1>Example</h1>",
    >>>                 "body": "# Example",
    >>>                 "comments_count": 100,
    >>>                 "created_at": "2000-01-01T00:00:00+00:00",
    >>>                 "id": "4bd431809afb1bb99e4f",
    >>>                 "likes_count": 100,
    >>>                 "private": false,
    >>>                 "reactions_count": 100,
    >>>                 "tags": [
    >>>                     {
    >>>                         "name": "Ruby",
    >>>                         "versions": [
    >>>                             "0.0.1"
    >>>                         ]
    >>>                     }
    >>>                 ],
    >>>                 "title": "Example title",
    >>>                 "updated_at": "2000-01-01T00:00:00+00:00",
    >>>                 "url": "https://qiita.com/yaotti/items/4bd431809afb1bb99e4f",
    >>>                 "user": {
    >>>                     "description": "Hello, world.",
    >>>                     "facebook_id": "yaotti",
    >>>                     "followees_count": 100,
    >>>                     "followers_count": 200,
    >>>                     "github_login_name": "yaotti",
    >>>                     "id": "yaotti",
    >>>                     "items_count": 300,
    >>>                     "linkedin_id": "yaotti",
    >>>                     "location": "Tokyo, Japan",
    >>>                     "name": "Hiroshige Umino",
    >>>                     "organization": "Increments Inc",
    >>>                     "permanent_id": 1,
    >>>                     "profile_image_url": "https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg",
    >>>                     "twitter_screen_name": "yaotti",
    >>>                     "website_url": "http://yaotti.hatenablog.com"
    >>>                 }
    >>>             }
    >>>         ]
    >>>     """
    Result.Ok
        [
            { rendered_body = "<h1>Example</h1>"
            , body = "# Example"
            , comments_count = 100
            , created_at =
                case Date.fromString "2000-01-01T00:00:00+00:00" of
                    Ok value ->
                        value
                    Err e ->
                        Debug.crash "Date format error" e
            , id = "4bd431809afb1bb99e4f"
            , likes_count = 100
            , private = False
            , reactions_count = 100
            , tags = [ { name = "Ruby", versions = [ "0.0.1" ] } ]
            , title = "Example title"
            , updated_at =
                case Date.fromString "2000-01-01T00:00:00+00:00" of
                    Ok value ->
                        value
                    Err e ->
                        Debug.crash "Date format error" e
            , url = "https://qiita.com/yaotti/items/4bd431809afb1bb99e4f"
            , user =
                { description = "Hello, world."
                , facebook_id = "yaotti"
                , followees_count = 100
                , followers_count = 200
                , github_login_name = "yaotti"
                , id = "yaotti"
                , items_count = 300
                , linkedin_id = "yaotti"
                , location = "Tokyo, Japan"
                , name = "Hiroshige Umino"
                , organization = "Increments Inc"
                , permanent_id = 1
                , profile_image_url = "https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg"
                , twitter_screen_name = "yaotti"
                , website_url = "http://yaotti.hatenablog.com"
                }
            }
        ]
-}
decodeItems : Decoder (List Item)
decodeItems =
    list decodeItem


-- Private


decodeItemTag : Decoder ItemTag
decodeItemTag =
    decode ItemTag
        |> required "name" string
        |> required "versions" (list string)


decodeItem : Decoder Item
decodeItem =
    decode Item
        |> required "rendered_body" string
        |> required "body" string
        |> required "comments_count" int
        |> required "created_at" date
        |> required "id" string
        |> required "likes_count" int
        |> required "private" bool
        |> required "reactions_count" int
        |> required "tags" (list decodeItemTag)
        |> required "title" string
        |> required "updated_at" date
        |> required "url" string
        |> required "user" decodeUser
