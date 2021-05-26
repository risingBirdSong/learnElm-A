module Main exposing (..)

-- https://elmprogramming.com/fetching-data-using-get.html

import Html exposing (..)
import Html.Events exposing (onClick)
import Browser
import Http
import Debug
import Json.Decode.Pipeline exposing (optional, optionalAt, required, requiredAt)
import Dict
import Json.Decode as Decode
    exposing
        ( Decoder
        , decodeString
        , field
        , int
        , list
        , map3
        , string
        )
type alias Model = {
  mystr : String ,
  myint : Int
  }

aaa = decodeString (field "id" int) "{ \"id\": 1 }"


bbb = decodeString string "\"Beanie\""

ccc = decodeString (field "id" int) "{ \"id\": 1 }"
ddd = decodeString (list (list int)) "[[1, 2], [4, 5]]"




type alias Simple = {value : String, id : Int}
type alias Nested = {mydata : Simple}

simpleDecoder : Decoder Simple
simpleDecoder = Decode.map2 Simple 
  (field "value" string)
  (field "id" int)

nestedDecoder : Decoder Nested
nestedDecoder = Decode.map Nested 
 (field "mydata" simpleDecoder)

simplea = Decode.decodeString simpleDecoder "{ \"value\":\"hello\",\"id\":1}"
nesteda = Decode.decodeString nestedDecoder "{ \"mydata\" : { \"value\":\"hello\",\"id\":1}}"

-- > Main.nesteda
-- Ok { mydata = { id = 1, value = "hello" } }
--     : Result Json.Decode.Error Main.Nested

url : String
url =
    "http://localhost:3000/simple"

cat = "meow"

type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)

view : Model -> Html Msg 
view model = 
  div [] [
    h1 [] [text "hello from connect"] , 
    h3 [] [text model.mystr] ,
    h3 [] [text (String.fromInt model.myint)] ,
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

      ({mystr = jsonlist, myint = 2}, Cmd.none)
    DataReceived (Err e) ->
      (model, Cmd.none)


main : Program () Model Msg
main =
    Browser.element
        { init = \flags -> ( {mystr = "start", myint = 1}  , Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

