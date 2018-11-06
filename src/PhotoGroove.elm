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

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random



{-
   Create view
-}


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


type ThumbnailSize
    = Small
    | Medium
    | Large


type Msg
    = ClickedPhoto String
    | GotSelectedIndex Int
    | ClickedSize ThumbnailSize
    | ClickedSurpriseMe



{-
   Transform Msg to custom type to allow for flexible
-}


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , button
            [ onClick ClickedSurpriseMe ]
            [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ]
            (List.map viewSizeChooser [ Small, Medium, Large ])
        , div [ id "thumbnails", class (sizeToString model.chosenSize) ]
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


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        , onClick (ClickedPhoto thumbnail.url)
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


viewSizeChooser : ThumbnailSize -> Html Msg
viewSizeChooser size =
    label []
        [ input [ type_ "radio", name "size", onClick (ClickedSize size) ] []
        , text (sizeToString size)
        ]



{-
   Generate a single radio button function to be passed
   into the view
-}


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"


type alias Photo =
    { url : String }



{-
   Use type alias to reduce code duplication. Here we are using
   type alias for the List/Array of photos
-}


type alias Model =
    { photos : List Photo
    , selectedUrl : String
    , chosenSize : ThumbnailSize
    }


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "3.jpeg"
    , chosenSize = Medium
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos



{-
   Convert List to Array so we can randomise the photos
-}


getPhotoUrl : Int -> String
getPhotoUrl index =
    case Array.get index photoArray of
        Just photo ->
            photo.url

        Nothing ->
            ""



{-
   Selecting a photo by url.
   Using destructuring to extract value from Just.
   Case expression used to cover a Maybe function
-}


randomPhotoPicker : Random.Generator Int
randomPhotoPicker =
    Random.int 0 (Array.length photoArray - 1)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSelectedIndex index ->
            ( { model | selectedUrl = getPhotoUrl index }, Cmd.none )

        ClickedPhoto url ->
            ( { model | selectedUrl = url }, Cmd.none )

        ClickedSize size ->
            ( { model | chosenSize = size }, Cmd.none )

        ClickedSurpriseMe ->
            ( model, Random.generate GotSelectedIndex randomPhotoPicker )



{-
   Update function allows the model to be changed
-}
{-
   Substitute if/else statement with case statement
-}
{-
   ClickedSurpriseMe
   1. Generate an Int between 0 and 2 using randomPhotoPicker
   2.  Take the randomly generated Int and pass to GotSelectedIndex
-}


main : Program () Model Msg
main =
    Browser.element
        { init = \flags -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }



{-
   Browser.sandbox lets us specify how to react to user input
   and update model
-}
{-
   Browser.sandbox changes to Browser.element.
   Browser.sandbox only returns a model, however the changes here
   are now returning a Model and a Command tupple.
-}
