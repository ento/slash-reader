CORENLP_DATE=2016-10-31
CORENLP_VERSION=3.7.0

all: elm.js main.css jar/stanford-corenlp-$(CORENLP_VERSION).jar build/icon.icns

elm.js: src/*.elm
	./node_modules/.bin/elm-make src/Main.elm --output elm.js

main.css: src/Stylesheet.elm src/CssMain.elm
	./node_modules/.bin/elm-css src/CssMain.elm -e ./node_modules/.bin/elm-make

jar/stanford-corenlp-$(CORENLP_VERSION).jar:
	curl -sO http://nlp.stanford.edu/software/stanford-corenlp-full-$(CORENLP_DATE).zip
	rm -rf jar stanford-corenlp-full-$(CORENLP_DATE)
	unzip stanford-corenlp-full-$(CORENLP_DATE).zip
	mv stanford-corenlp-full-$(CORENLP_DATE) jar
	rm stanford-corenlp-full-$(CORENLP_DATE).zip


build/icon.icns: assets/icon_512.png
	mkdir build/icon.iconset
	sips -z 16 16   assets/icon_512.png --out build/icon.iconset/icon_16x16.png
	sips -z 32 32   assets/icon_512.png --out build/icon.iconset/icon_16x16@2x.png
	sips -z 32 32   assets/icon_512.png --out build/icon.iconset/icon_32x32.png
	sips -z 64 64   assets/icon_512.png --out build/icon.iconset/icon_32x32@2x.png
	sips -z 128 128 assets/icon_512.png --out build/icon.iconset/icon_128x128.png
	sips -z 256 256 assets/icon_512.png --out build/icon.iconset/icon_128x128@2x.png
	sips -z 256 256 assets/icon_512.png --out build/icon.iconset/icon_256x256.png
	cp assets/icon_512.png build/icon.iconset/icon_512x512@2x.png
	iconutil -c icns build/icon.iconset
	rm -R build/icon.iconset

.PHONY: dist
dist: elm.js main.css jar/stanford-corenlp-$(CORENLP_VERSION).jar build/icon.icns
	CSC_IDENTITY_AUTO_DISCOVERY=false npm run dist
