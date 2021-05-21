<<<<<<< HEAD
module Main exposing (Model)

-- https://elmprogramming.com/fetching-data-using-get.html

import Html exposing (..)
import Html.Events exposing (onClick)
import Browser
import Http
import Debug


type alias Model = String

type alias Simple = {value : String, id : Int}


url : String
url =
    "http://localhost:3000/simple"


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)


view : Model -> Html Msg 
view model = 
  div [] [
    h1 [] [text "hello from connect"] , 
    h3 [] [text model] ,
    button [onClick SendHttpRequest] [text "click to fire off request"] 
  ]

queryForSimple : Cmd Msg
queryForSimple = 
  Http.get {
    url = url ,
    expect = Http.expectString DataReceived
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    SendHttpRequest ->
      (model, queryForSimple )
    DataReceived (Ok jsonlist) ->

      (jsonlist, Cmd.none)
    DataReceived (Err e) ->
      (model, Cmd.none)


main : Program () Model Msg
main =
    Browser.element
        { init = \flags -> ( "start", Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
=======
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
  Browser.element
    { init = \flags -> ([], Cmd.none)
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }

-- MODEL


type alias Model =
  { value : String, submitted : String}


init : Model
init =
  Model "starting" ""



-- UPDATE


url : String
url = "http://localhost:3000/simple" 

type Error
    = BadUrl String
    | Timeout
    | NetworkError
    | BadStatus Int
    | BadBody String

type Msg
  = Simple String
    | SendHttpRequest
    | DataReceived (Result Error String)




getSimple : Cmd Msg
getSimple =
    Http.get
        { url = url
        , expect = Http.expectString DataReceived
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SendHttpRequest ->
      ( model , getSimple )
 




-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" model.value model.value Simple
        , button [ onClick (SendHttpRequest) ] [ text "asdfds" ],
        div [] [text model.submitted]
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

>>>>>>> 314d5458a2dbe97cdfb7c861e8c1dec0afa5c249
