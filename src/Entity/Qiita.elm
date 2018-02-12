module Entity.Qiita exposing (User, ItemTag, Item, StockItem)


import Date exposing (Date)


type alias User =
    { description: Maybe String
    , facebook_id: Maybe String
    , followees_count: Int
    , followers_count: Int
    , github_login_name: Maybe String
    , id: String
    , items_count: Int
    , linkedin_id: Maybe String
    , location: Maybe String
    , name: String
    , organization: Maybe String
    , permanent_id: Int
    , profile_image_url: String
    , twitter_screen_name: Maybe String
    , website_url: Maybe String
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


type alias StockItem =
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
    , page_views_count: Int
    }
