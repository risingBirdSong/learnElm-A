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