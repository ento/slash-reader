'use strict'
const path = require('path')
const Elm = require('./elm.js')
const StandfordSimpleNLP = require('stanford-simple-nlp').StanfordSimpleNLP
const parser = new StandfordSimpleNLP()

let java;
let jarDir;

if (path.extname(__dirname) === '.asar') {
  const unpackedDir = path.resolve(__dirname, '..', 'app.asar.unpacked')
  java = require(path.join(unpackedDir, 'node_modules', 'java'))
  jarDir = path.join(unpackedDir, 'jar')
} else {
  java = require('java')
  jarDir = path.join(__dirname, 'jar')
}

parser.loadPipeline({path: jarDir, java: java}, function (err) {
  if (err) {
    console.log(err);
  }
  const app = Elm.Main.fullscreen()

  const handleParseResult = function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result.document.sentences.sentence.parsedTree) {
      app.ports.parseResult.send([result.document.sentences.sentence.parsedTree])
    } else {
      const trees = result.document.sentences.sentence.map(function(sentence) {
        return sentence.parsedTree
      })
      app.ports.parseResult.send(trees)
    }
  }

  app.ports.parse.subscribe(function(str) {
    parser.process(str, handleParseResult);
  });
});
