module Entity.Qiita exposing (User)


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
