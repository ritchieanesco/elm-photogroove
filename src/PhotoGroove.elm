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

import Browser
import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



{-
   Create view
-}


urlPrefix =
    "http://elm-in-action.com/"


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ]
            (List.map (viewThumbnail model.selectedUrl)
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
        , onClick { description = "ClickedPhoto", data = thumbnail.url }
        ]
        []



{-
   Use Html.classList to determine if thumbnail is selected
   classList uses a list of tuples, first providing classname
   and the condition for that classname
-}
{-
   Attach onClick event and pass a record for the update function
-}


initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "3.jpeg"
    }


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }

    else
        model



{-
   Update function allows the model to be changed
-}


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



{-
   Browser.sandbox lets us specify how to react to user input
   and update model
-}
