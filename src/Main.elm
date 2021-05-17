-- Press a button to send a GET request for random cat GIFs.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/json.html
--
module Main exposing (..)



-- Input a user name and password. Make sure the password matches.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/forms.html
--

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Json.Decode exposing (Value)
import Html.Events exposing (onClick)
import Http




-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { value : String, submitted : String}


init : Model
init =
  Model "starting" ""



-- UPDATE


type Msg
  = Simple String
    | Submit




update : Msg -> Model -> Model
update msg model =
  case msg of
    Simple val ->
      { model | value = val }
    Submit ->
      {model | value = "starting", submitted = model.value }




-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" model.value model.value Simple
        , button [ onClick (Submit) ] [ text "asdfds" ],
        div [] [text model.submitted]
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

