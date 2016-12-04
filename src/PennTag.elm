module PennTag exposing (..)

{-| Penn Treebank Tags.

Reference:
- http://web.mit.edu/6.863/www/PennTreebankTags.html#VP
- http://stackoverflow.com/a/21546294/20226
-}

import Regex


type PennTag
    = ROOT {- Clause level -}
    | S
      -- simple declarative clause, i.e. one that is not introduced by a (possible empty) subordinating conjunction or a wh-word and that does not exhibit subject-verb inversion.
    | SBAR
      -- Clause introduced by a (possibly empty) subordinating conjunction.
    | SBARQ
      -- Direct question introduced by a wh-word or a wh-phrase. Indirect questions and relative clauses should be bracketed as SBAR, not SBARQ.
    | SINV
      -- Inverted declarative sentence, i.e. one in which the subject follows the tensed verb or modal.
    | SQ
      -- Inverted yes/no question, or main clause of a wh-question, following the wh-phrase in SBARQ.
      {- Phrase level -}
    | ADJP
      -- Adjective Phrase.
    | ADVP
      -- Adverb Phrase.
    | CONJP
      -- Conjunction Phrase.
    | FRAG
      -- Fragment.
    | INTJ
      -- Interjection. Corresponds approximately to the part-of-speech tag UH.
    | LST
      -- List marker. Includes surrounding punctuation.
    | NAC
      -- Not a Constituent; used to show the scope of certain prenominal modifiers within an NP.
    | NP
      -- Noun Phrase.
    | NX
      -- Used within certain complex NPs to mark the head of the NP. Corresponds very roughly to N-bar level but used quite differently.
    | PP
      -- Prepositional Phrase.
    | PRN
      -- Parenthetical.
    | PRT
      -- Particle. Category for words that should be tagged RP.
    | QP
      -- Quantifier Phrase (i.e. complex measure/amount phrase); used within NP.
    | RRC
      -- Reduced Relative Clause.
    | UCP
      -- Unlike Coordinated Phrase.
    | VP
      -- Vereb Phrase.
    | WHADJP
      -- Wh-adjective Phrase. Adjectival phrase containing a wh-adverb, as in how hot.
    | WHAVP
      -- Wh-adverb Phrase. Introduces a clause with an NP gap. May be null (containing the 0 complementizer) or lexical, containing a wh-adverb such as how or why.
    | WHNP
      -- Wh-noun Phrase. Introduces a clause with an NP gap. May be null (containing the 0 complementizer) or lexical, containing some wh-word, e.g. who, which book, whose daughter, none of which, or how many leopards.
    | WHPP
      -- Wh-prepositional Phrase. Prepositional phrase containing a wh-noun phrase (such as of which or by whose authority) that either introduces a PP gap or is contained by a WHNP.
    | X
      -- Unknown, uncertain, or unbracketable. X is often used for bracketing typos and in bracketing the...the-constructions.
      {- Word level -}
    | CC
      -- Coordinating conjunction
    | CD
      -- Cardinal number
    | DT
      -- Determiner
    | EX
      -- Existential there
    | FW
      -- Foreign word
    | IN
      -- Preposition or subordinating conjunction
    | JJ
      -- Adjective
    | JJR
      -- Adjective, comparative
    | JJS
      -- Adjective, superlative
    | LS
      -- List item marker
    | MD
      -- Modal
    | NN
      -- Noun, singular or mass
    | NNS
      -- Noun, plural
    | NNP
      -- Proper noun, singular
    | NNPS
      -- Proper noun, plural
    | PDT
      -- Predeterminer
    | POS
      -- Possessive ending
    | PRP
      -- Personal pronoun
    | PRPS
      -- Possessive pronoun (prolog version PRP-S)
    | RB
      -- Adverb
    | RBR
      -- Adverb, comparative
    | RBS
      -- Adverb, superlative
    | RP
      -- Particle
    | SYM
      -- Symbol
    | TO
      -- to
    | UH
      -- Interjection
    | VB
      -- Verb, base form
    | VBD
      -- Verb, past tense
    | VBG
      -- Verb, gerund or present participle
    | VBN
      -- Verb, past participle
    | VBP
      -- Verb, non-3rd person singular present
    | VBZ
      -- Verb, 3rd person singular present
    | WDT
      -- Wh-determiner
    | WP
      -- Wh-pronoun
    | WPS
      -- Possessive wh-pronoun (prolog version WP-S)
    | WRB
      -- Wh-adverb
      {- Punctuation tags -}
    | Pound
      -- #
    | Dollar
      -- $
    | ClosingQuote
      -- '' (used for all forms of closing quote)
    | OpeningParen
      -- ( (used for all forms of opening parenthesis)
    | ClosingParen
      -- ) (used for all forms of closing parenthesis)
    | Comma
      -- ,
    | Period
      -- . (used for all sentence-ending punctuation)
    | Colon
      -- : (used for colons, semicolons and ellipses)
    | OpeningQuote



-- `` (used for all forms of opening quote)


fromString : String -> PennTag
fromString s =
    let
        alphabetical =
            Regex.replace Regex.All (Regex.regex "\\$") (\_ -> "S") s
    in
        case alphabetical of
            "ROOT" ->
                ROOT

            "S" ->
                S

            "SBAR" ->
                SBAR

            "SBARQ" ->
                SBARQ

            "SINV" ->
                SINV

            "SQ" ->
                SQ

            "ADJP" ->
                ADJP

            "ADVP" ->
                ADVP

            "CONJP" ->
                CONJP

            "FRAG" ->
                FRAG

            "INTJ" ->
                INTJ

            "LST" ->
                LST

            "NAC" ->
                NAC

            "NP" ->
                NP

            "NX" ->
                NX

            "PP" ->
                PP

            "PRN" ->
                PRN

            "PRT" ->
                PRT

            "QP" ->
                QP

            "RRC" ->
                RRC

            "UCP" ->
                UCP

            "VP" ->
                VP

            "WHADJP" ->
                WHADJP

            "WHAVP" ->
                WHAVP

            "WHNP" ->
                WHNP

            "WHPP" ->
                WHPP

            "X" ->
                X

            "CC" ->
                CC

            "CD" ->
                CD

            "DT" ->
                DT

            "EX" ->
                EX

            "FW" ->
                FW

            "IN" ->
                IN

            "JJ" ->
                JJ

            "JJR" ->
                JJR

            "JJS" ->
                JJS

            "LS" ->
                LS

            "MD" ->
                MD

            "NN" ->
                NN

            "NNS" ->
                NNS

            "NNP" ->
                NNP

            "NNPS" ->
                NNPS

            "PDT" ->
                PDT

            "POS" ->
                POS

            "PRP" ->
                PRP

            "PRPS" ->
                PRPS

            "RB" ->
                RB

            "RBR" ->
                RBR

            "RBS" ->
                RBS

            "RP" ->
                RP

            "SYM" ->
                SYM

            "TO" ->
                TO

            "UH" ->
                UH

            "VB" ->
                VB

            "VBD" ->
                VBD

            "VBG" ->
                VBG

            "VBN" ->
                VBN

            "VBP" ->
                VBP

            "VBZ" ->
                VBZ

            "WDT" ->
                WDT

            "WP" ->
                WP

            "WPS" ->
                WPS

            "WRB" ->
                WRB

            "#" ->
                Pound

            "$" ->
                Dollar

            "''" ->
                ClosingQuote

            "-LRB-" ->
                OpeningParen

            "-RRB-" ->
                ClosingParen

            "," ->
                Comma

            "." ->
                Period

            ":" ->
                Colon

            "``" ->
                OpeningQuote

            _ ->
                X
