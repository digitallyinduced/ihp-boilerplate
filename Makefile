CSS_FILES += TurboHaskell/TurboHaskell/static/vendor/bootstrap.min.css
CSS_FILES += TurboHaskell/TurboHaskell/static/vendor/flatpickr.min.css

JS_FILES += TurboHaskell/TurboHaskell/static/vendor/jquery-3.2.1.slim.min.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/timeago.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/popper.min.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/bootstrap.min.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/flatpickr.js
JS_FILES += TurboHaskell/TurboHaskell/static/helpers.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/morphdom-umd.min.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/turbolinks.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/turbolinksInstantClick.js
JS_FILES += TurboHaskell/TurboHaskell/static/vendor/turbolinksMorphdom.js

ifneq ($(wildcard TurboHaskell/.*),)
TURBOHASKELL = TurboHaskell
else
TURBOHASKELL = $(shell dirname $$(which RunDevServer))/..
endif

include ${TURBOHASKELL}/Makefile.dist