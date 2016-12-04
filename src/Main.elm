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
    { sents : List (Result String SyntaxTree)
    , lastError : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { sents = [], lastError = Nothing }, parse initInput )


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
    model.sents
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
                sents =
                    List.map SyntaxTree.fromJson results
            in
                ( { model | sents = sents }, Cmd.none )

        Parse str ->
            ( model, parse str )


port parseResult : (List Json.Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    parseResult ParseResult
