module PhotoGroove exposing(..)

import Html exposing (..)
import Html.Attributes exposing (..)

view model =
  div [ class "content" ]
      [ h1 [ class "h1" ] [ text "Photo Groove" ]
      , div [ id "thumbnails" ]
          [ img [ src "http://elm-in-action.com/1.jpeg", class "img1" ] []
          , img [ src "http://elm-in-action.com/1.jpeg", class "img2" ] []
          , img [ src "http://elm-in-action.com/1.jpeg", class "img3" ] []
          ]
      ]

main =
    view "no model yet"