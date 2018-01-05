module Entity.Qiita exposing (User, ItemTag, Item)


import Date exposing (Date)


type alias User =
    { description: String
    , facebook_id: String
    , followees_count: Int
    , followers_count: Int
    , github_login_name: String
    , id: String
    , items_count: Int
    , linkedin_id: String
    , location: String
    , name: String
    , organization: String
    , permanent_id: Int
    , profile_image_url: String
    , twitter_screen_name: String
    , website_url: String
    }


type alias ItemTag =
    { name: String
    , versions: List String
    }


type alias Item =
    { rendered_body: String
    , body: String
    , comments_count: Int
    , created_at: Date
    , id: String
    , likes_count: Int
    , private: Bool
    , reactions_count: Int
    , tags: List ItemTag
    , title: String
    , updated_at: Date
    , url: String
    , user: User
    }
