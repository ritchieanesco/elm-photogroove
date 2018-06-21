module PhotoGroove exposing(..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- view model =
--   div [ class "content" ]
--       [ h1 [ class "h1" ] [ text "Photo Groove" ]
--       , div [ id "thumbnails" ]
--           [ img [ src "http://elm-in-action.com/1.jpeg", class "img1" ] []
--           , img [ src "http://elm-in-action.com/1.jpeg", class "img2" ] []
--           , img [ src "http://elm-in-action.com/1.jpeg", class "img3" ] []
--           ]
--       ]

urlPrefix = "http://elm-in-action.com/"

viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        ]
        []

view model =
    div [ class "content" ]
        [ h1 [] [ text " Photo Groove" ]
        , div [ id "thumbnails" ]
            -- (List.map (\photo -> viewThumbnail model.selectedUrl photo) -- anonymous
            (List.map (viewThumbnail model.selectedUrl) -- partial application (does not need all args)
                model.photos
            )
        , img
            [ class "large"
            , src ( urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]

-- (List.map = iterate through array
-- (\photo -> viewThumbnail model.selectedUrl photo) = is anonymous function
-- model.photos = the args/data to be passed into

initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
        , selectedUrl = "1.jpeg"
    }

main =
    view initialModel