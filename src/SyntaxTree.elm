module SyntaxTree exposing (SyntaxTree, fromJson, viewResult)

{-| Parse and view syntax tree as parsed by Stanfod CoreNLP.

@docs SyntaxTree, fromJson, viewResult
-}

import Css
import Json.Decode as Json exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers exposing (withNamespace)
import PennTag exposing (PennTag(..))
import Stylesheet exposing (root, slashed, tree, SlashClass(..))


{-| Recursive tree structure to hold a parsed sentence.
-}
type SyntaxTree
    = Phrase PhraseData
    | Word WordData


type alias PhraseData =
    { slash : SlashClass
    , tag : PennTag
    , children : List SyntaxTree
    }


type alias WordData =
    { id : Int
    , tag : PennTag
    , word : String
    }



-- DECODER


{-| Parse a single `parsedTree` structure returned by
`stanford-simple-nlp` npm module's API.
-}
fromJson : Json.Value -> Result String SyntaxTree
fromJson value =
    decodeValue syntaxTree value
        |> Result.map placeSlashes


syntaxTree : Json.Decoder SyntaxTree
syntaxTree =
    oneOf
        [ Json.map
            Phrase
            (map2 (PhraseData None)
                (field "type" (Json.map PennTag.fromString string))
                (field "children" (Json.list (lazy (\_ -> syntaxTree))))
            )
        , Json.map
            Word
            (map3
                WordData
                (field "id" int)
                (field "type" (Json.map PennTag.fromString string))
                (field "word" string)
            )
        ]


placeSlashes : SyntaxTree -> SyntaxTree
placeSlashes tree =
    case tree of
        Phrase data ->
            let
                newChildren =
                    data.children
                        |> List.map placeSlashes

                newSlash =
                    slashForPhrase data
            in
                Phrase { data | slash = newSlash, children = newChildren }

        Word data ->
            Word data


slashForPhrase : PhraseData -> SlashClass
slashForPhrase data =
    case data.tag of
        PP ->
            Both

        SBAR ->
            Left

        Comma ->
            Right

        Colon ->
            Right

        _ ->
            None



-- VIEW


viewResult : Result String SyntaxTree -> Html msg
viewResult result =
    case result of
        Ok tree ->
            viewTree tree

        Err error ->
            viewError error


viewTree : SyntaxTree -> Html msg
viewTree tree =
    case tree of
        Phrase data ->
            viewPhrase data

        Word data ->
            viewWord data


viewPhrase : PhraseData -> Html msg
viewPhrase data =
    data.children
        |> List.map viewTree
        |> span
            [ slashed.class [ data.slash ]
            , tree.class [ Stylesheet.Phrase ]
            , tree.class [ data.tag ]
            ]


viewWord : WordData -> Html msg
viewWord data =
    let
        displayText =
            case data.tag of
                OpeningParen ->
                    "("

                ClosingParen ->
                    ")"

                _ ->
                    data.word
    in
        span
            [ tree.class [ Stylesheet.Word ]
            , tree.class [ data.tag ]
            ]
            [ text displayText ]


viewError : String -> Html msg
viewError error =
    text ("Error: " ++ error)
