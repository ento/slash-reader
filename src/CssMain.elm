port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Stylesheet


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "main.css", Css.File.compile [ Stylesheet.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
