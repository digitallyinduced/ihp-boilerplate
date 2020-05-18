CSS_FILES += IHP/IHP/static/vendor/bootstrap.min.css
CSS_FILES += IHP/IHP/static/vendor/flatpickr.min.css

JS_FILES += IHP/IHP/static/vendor/jquery-3.2.1.slim.min.js
JS_FILES += IHP/IHP/static/vendor/timeago.js
JS_FILES += IHP/IHP/static/vendor/popper.min.js
JS_FILES += IHP/IHP/static/vendor/bootstrap.min.js
JS_FILES += IHP/IHP/static/vendor/flatpickr.js
JS_FILES += IHP/IHP/static/helpers.js
JS_FILES += IHP/IHP/static/vendor/morphdom-umd.min.js
JS_FILES += IHP/IHP/static/vendor/turbolinks.js
JS_FILES += IHP/IHP/static/vendor/turbolinksInstantClick.js
JS_FILES += IHP/IHP/static/vendor/turbolinksMorphdom.js

ifneq ($(wildcard IHP/.*),)
TURBOHASKELL = IHP
else
TURBOHASKELL = $(shell dirname $$(which RunDevServer))/..
endif

include ${TURBOHASKELL}/Makefile.dist