#!/bin/bash -ex

CORENLP_VERSION=$1
CORENLP_DATE=$2

rm -rf jar stanford-corenlp-full-$CORENLP_DATE
mkdir jar
unzip stanford-corenlp-full-$CORENLP_DATE.zip

while read -r copy_asis; do
    mv stanford-corenlp-full-$CORENLP_DATE/$copy_asis jar/
    touch jar/$copy_asis
done <<EOF
LIBRARY-LICENSES
LICENSE.txt
ejml-*.jar
javax.json.jar
joda-time.jar
jollyday.jar
patterns
protobuf.jar
slf4j-api.jar
slf4j-simple.jar
stanford-corenlp-$CORENLP_VERSION.jar
sutime
tokensregex
xom.jar
EOF

models_jar="stanford-corenlp-full-$CORENLP_DATE/stanford-corenlp-$CORENLP_VERSION-models.jar"
dest_models_jar="jar/stanford-corenlp-$CORENLP_VERSION-models.jar"

mv "$models_jar" "$dest_models_jar"

while read -r model; do
    zip -d "$dest_models_jar" "edu/stanford/nlp/models/$model/*"
done <<EOF
coref
dcoref
gender
kbp
naturalli
ner
regexner
sentiment
supervised_relation_extractor
sutime
truecase
ud
upos
EOF

rm -rf stanford-corenlp-full-$CORENLP_DATE
