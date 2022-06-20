dav.min.js dav.js.map: dav.js node_modules
	./node_modules/.bin/minify dav.js --out-file ./dav.min.js

dav.js: build node_modules
	-rm -rf dav.js /tmp/dav.js
	./node_modules/.bin/browserify --standalone dav ./build/index.js \
                -t [ babelify --presets [ @babel/preset-env ] ] \
                --outfile ./tmp/dav.js
	cat ./lib/polyfill/*.js ./tmp/dav.js > dav.js

.PHONY: build
build: node_modules
	-rm -rf build/
	./node_modules/.bin/babel lib --out-dir build

node_modules: package.json
	npm install

.PHONY: clean
clean:
	-rm -rf *.zip SabreDAV build coverage dav.*

.PHONY: test
test: test-unit

.PHONY: test-unit
test-unit: node_modules
	./node_modules/.bin/mocha test/unit
