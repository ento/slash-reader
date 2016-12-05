This app helps you understand long English sentences by slashing them up into chunks.

![Screenshot](https://cloud.githubusercontent.com/assets/21108/20870624/5a63ddd6-ba40-11e6-8337-486b5a2349b0.png)

These slashes are placed based on the following rules:

1. Before and after a propositional phrase
2. After a comma, a semilcolon, or a colon
3. Before a that-clause, a wh-clause, or a whether-clause
4. Before a relative pronoun or a relative adverb
5. Before a non-finite verb _(to be implemented)_
6. Before a conjunction that connects sentences
7. Before a long object or a complement _(to be implemented)_
8. After a long subject _(to be implemented)_

[Reference](http://knowledge-plus.com/english/802/)


This app comes bundled with a subset of [Stanford CoreNLP](http://stanfordnlp.github.io/CoreNLP/).

## Tinkering

```
npm install
./node_modules/.bin/electron-rebuild -e=./node_modules/electron-prebuilt/
./node_modules/.bin/elm-package install
make
./node_modules/.bin/electron main.js
```

## Packaging

```
make dist
```
