{-
   Declare a new module.
   Expose main function
   Should another module try to import View (PhotoGroove.View)
   an error would occur
-}


module PhotoGroove exposing (main)

{-
   Import other modules
-}

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)



{-
   Create view
-}


urlPrefix =
    "http://elm-in-action.com/"


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map viewThumbnail model)
        ]


viewThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url) ] []


initialModel =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]


main =
    view initialModel
