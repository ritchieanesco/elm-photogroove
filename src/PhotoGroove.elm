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
        , div [ id "thumbnails" ]
            (List.map (\photo -> viewThumbnail model.selectedUrl photo)
                model.photos
            )
        , img
            [ class "large"
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]



{-
   Use anonymous function to pass selected url and photo data
-}


viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        ]
        []



{-
   Use Html.classList to determine if thumbnail is selected
   classList uses a list of tuples, first providing classname
   and the condition for that classname
-}


initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "3.jpeg"
    }


main =
    view initialModel
