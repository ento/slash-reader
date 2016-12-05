port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Html.Events exposing (..)
import Json.Encode as Json
import Stylesheet exposing (root, UiClass(..))
import SyntaxTree exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { sentences : List (Result String SyntaxTree)
    }


init : ( Model, Cmd Msg )
init =
    ( { sentences = [] }, parse initInput )


initInput : String
initInput =
    --    "The best I can figure is that I'm somewhere around 52nd or 53nd most popular this year."
    "Mr. and Mrs. Dursley, of number four Privet Drive, were proud to say that they were perfectly normal, thank you very much."


view : Model -> Html Msg
view model =
    div []
        [ viewInput model
        , viewResult model
        ]


viewInput : Model -> Html Msg
viewInput model =
    section []
        [ textarea
            [ onInput Parse
            , placeholder initInput
            , root.class [ Input ]
            ]
            []
        ]


viewResult : Model -> Html msg
viewResult model =
    model.sentences
        |> List.map SyntaxTree.viewResult
        |> List.map (\result -> section [ root.class [ Result ] ] [ result ])
        |> section [ root.class [ ResultContainer ] ]


type Msg
    = Parse String
    | ParseResult (List Json.Value)


port parse : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ParseResult results ->
            let
                sentences =
                    List.map SyntaxTree.fromJson results
            in
                ( { model | sentences = sentences }, Cmd.none )

        Parse str ->
            ( model, parse str )


port parseResult : (List Json.Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    parseResult ParseResult
