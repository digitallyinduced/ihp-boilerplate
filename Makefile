CSS_FILES += ${IHP}/static/vendor/bootstrap.min.css
CSS_FILES += ${IHP}/static/vendor/flatpickr.min.css
CSS_FILES += static/app.css

JS_FILES += ${IHP}/static/vendor/jquery-4.0.0.slim.min.js
JS_FILES += ${IHP}/static/vendor/timeago.js
JS_FILES += ${IHP}/static/vendor/popper-2.11.6.min.js
JS_FILES += ${IHP}/static/vendor/bootstrap.min.js
JS_FILES += ${IHP}/static/vendor/flatpickr.js
JS_FILES += ${IHP}/static/helpers.js
JS_FILES += ${IHP}/static/vendor/turbo.js

include ${IHP}/Makefile.dist

