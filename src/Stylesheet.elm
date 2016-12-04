module Stylesheet
    exposing
        ( TreeClass(..)
        , UiClass(..)
        , SlashClass(..)
        , css
        , root
        , tree
        , slashed
        )

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import PennTag exposing (PennTag(..))


type TreeClass
    = Phrase
    | Word


type UiClass
    = Input
    | Result
    | ResultContainer


type SlashClass
    = None
    | Left
    | Right
    | Both


root =
    withNamespace ""


css =
    (stylesheet)
        (uis ++ trees ++ slashes)


uis : List Snippet
uis =
    [ (.) Input
        [ width (vw 95)
        , padding (px 4)
        , fontSize (px 16)
        ]
    , (.) ResultContainer
        [ marginTop (px 20)
        , fontSize (px 20)
        , borderTop3 (px 1) solid (hex "#EBEBEB")
        ]
    , (.) Result
        [ paddingTop (px 20)
        , paddingBottom (px 20)
        , borderBottom3 (px 1) solid (hex "#EBEBEB")
        ]
    ]


tree =
    withNamespace "tree-"


trees : List Snippet
trees =
    (namespace tree.name)
        ([ (.) Phrase
            []
         , (.) Word
            ([ marginLeft (ex 0.5) ] ++ noLeftMarginWords)
         ]
            ++ noRightMarginWords
        )


noLeftMarginWords : List Mixin
noLeftMarginWords =
    [ Comma, Colon, Period, ClosingQuote, ClosingParen ]
        |> List.map (\class -> withClass class [ marginLeft (ex 0) ])


noRightMarginWords : List Snippet
noRightMarginWords =
    let
        noLeftMarginAfter class =
            (.) class
                [ adjacentSiblings
                    [ (.) Word
                        [ marginLeft (ex 0) ]
                    ]
                ]
    in
        [ OpeningQuote, OpeningParen ]
            |> List.map noLeftMarginAfter


slashed =
    withNamespace "slash-"


slashes : List Snippet
slashes =
    (namespace slashed.name)
        [ (.) Left
            [ before forwardSlash ]
        , (.) Right
            [ after forwardSlash ]
        , (.) Both
            [ before forwardSlash
            , after forwardSlash
            ]
        ]


forwardSlash : List Mixin
forwardSlash =
    [ property "content" "\"/\""
    , transform (scaleY 2)
    , display inlineBlock
    , paddingLeft (px 2)
    , paddingRight (px 2)
    ]
