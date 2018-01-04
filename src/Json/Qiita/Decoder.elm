module Json.Qiita.Decoder exposing (decodeUser)


import Json.Decode exposing (Decoder, list, int, string)
import Json.Decode.Pipeline exposing (decode, required)
import Entity.Qiita exposing (User, ItemTag)


{-| Qiita user object decoder.

Usage:

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


{-| Qiita items in tag object decoder.

Usage:

    >>> Json.Decode.decodeString
    >>>     decodeItemTag
    >>>     """
    >>>         {
    >>>             "name": "elm",
    >>>             "versions": ["0.18.0", "0.19.0"]
    >>>         }
    >>>     """
    Result.Ok
        { name = "elm"
        , versions = ["0.18.0", "0.19.0"]
        }
-}
decodeItemTag : Decoder ItemTag
decodeItemTag =
    decode ItemTag
        |> required "name" string
        |> required "versions" (list string)
