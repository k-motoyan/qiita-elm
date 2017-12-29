module API.Qiita exposing (Version(..), createUrl)


type Version
    = V2


basePath : String
basePath = "https://qiita.com/api/"


versionToString : Version -> String
versionToString version =
    case version of
        V2 -> "v2"


createUrl : Version -> String -> String
createUrl version path =
    basePath ++ versionToString version ++ "/" ++ path
