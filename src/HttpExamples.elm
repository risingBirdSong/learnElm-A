module HttpExamples exposing (Model)

-- https://elmprogramming.com/fetching-data-using-get.html

import Html exposing (..)
import Html.Events exposing (onClick)
import Browser
import Http

-- Simple {value : String, id : Number}

type alias Point =
  { x : Float
  , y : Float
  }

type alias Model =
    List String

type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)

url : String
url =
    "http://localhost:5016/old-school.txt"

getNicknames : Cmd Msg
getNicknames =
    Http.get
        { url = url
        , expect = Http.expectString DataReceived
        }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getNicknames )

        DataReceived (Ok nicknamesStr) ->
            let
                nicknames =
                    String.split "," nicknamesStr
            in
            ( nicknames, Cmd.none )

        DataReceived (Err _) ->
            ( model, Cmd.none )

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , h3 [] [ text "Old School Main Characters" ]
        , ul [] (List.map viewNickname model)
        ]


viewNickname : String -> Html Msg
viewNickname nickname =
    li [] [ text nickname ]


main : Program () Model Msg
main =
    Browser.element
        { init = \flags -> ( [], Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }