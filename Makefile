CSS_FILES += ${IHP}/static/vendor/bootstrap.min.css
CSS_FILES += ${IHP}/static/vendor/flatpickr.min.css
CSS_FILES += static/app.css

JS_FILES += ${IHP}/static/vendor/jquery-3.6.0.slim.min.js
JS_FILES += ${IHP}/static/vendor/timeago.js
JS_FILES += ${IHP}/static/vendor/popper.min.js
JS_FILES += ${IHP}/static/vendor/bootstrap.min.js
JS_FILES += ${IHP}/static/vendor/flatpickr.js
JS_FILES += ${IHP}/static/helpers.js
JS_FILES += ${IHP}/static/vendor/morphdom-umd.min.js
JS_FILES += ${IHP}/static/vendor/turbolinks.js
JS_FILES += ${IHP}/static/vendor/turbolinksInstantClick.js
JS_FILES += ${IHP}/static/vendor/turbolinksMorphdom.js
JS_FILES += static/miso/index.js
JS_FILES += static/miso/ghc_wasm_jsffi.js

include ${IHP}/Makefile.dist

static/miso/index.js:
	cp miso/index.js static/miso/

.ONESHELL:
static/miso/ghc_wasm_jsffi.js:
	wasm32-wasi-cabal build Frontend
	hs_wasm_path=$(shell wasm32-wasi-cabal list-bin Frontend)
	hs_wasm_libdir=$(shell wasm32-wasi-ghc --print-libdir)
	"$$hs_wasm_libdir"/post-link.mjs --input "$$hs_wasm_path" --output static/miso/ghc_wasm_jsffi.js
	cp "$$hs_wasm_path" static/miso/bin.wasm
