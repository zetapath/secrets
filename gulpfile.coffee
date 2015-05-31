"use strict"

# -- DEPENDENCIES --------------------------------------------------------------
gulp          = require "gulp"
cjsx          = require "gulp-cjsx"
concat        = require "gulp-concat"
connect       = require "gulp-connect"
header        = require "gulp-header"
gutil         = require "gulp-util"
uglify        = require "gulp-uglify"
stylus        = require "gulp-stylus"
pkg           = require "./package.json"
# -- BROWSERIFY ----------------------------------------------------------------
browserify    = require "browserify"
source        = require "vinyl-source-stream"
bundler       = browserify "./source/app.cjsx", extensions: [".cjsx", ".coffee"]
bundler.transform require "coffee-reactify"
# -- FILES ---------------------------------------------------------------------
path =
  dist          :   "./dist"
  source        : [ "source/**/*.cjsx"
                    "source/**/*.coffee"]
  style         : [ "bower_components/STYLmethods/vendor.styl"
                    "source/styles/__constants.styl"
                    "source/styles/normalize.styl"
                    "source/styles/app.styl"
                    "source/styles/app.*.styl"]
  thirds:
    js          : [ "bower_components/react/react-with-addons.js"
                    "bower_components/hamsa/dist/hamsa.js"
                    "bower_components/hope/hope.js"
                    "bower_components/moment/min/moment.min.js"
                    "bower_components/quojs/quo.js"
                    "bower_components/quojs/quo.ajax.js"]
    css         : [ "node_modules/leaflet/dist/leaflet.css"]
# -- BANNER --------------------------------------------------------------------
banner = [
  "/**"
  " * <%= pkg.name %> - <%= pkg.description %>"
  " * @version v<%= pkg.version %>"
  " * @link    <%= pkg.homepage %>"
  " * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)"
  " * @license <%= pkg.license %>"
  " */"
  ""
].join("\n")
# -- TASKS ---------------------------------------------------------------------
gulp.task "server", ->
  connect.server
    port      : 8000
    livereload: true
    root      : path.dist

gulp.task "source", ->
  bundler.bundle()
    .on "error", gutil.log.bind(gutil, "Browserify Error")
    .pipe source "#{pkg.name}.js"
    # .pipe uglify mangle: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.dist}/assets/js"
    .pipe connect.reload()

gulp.task "style", ->
  gulp.src path.style
    .pipe concat "#{pkg.name}.styl"
    .pipe stylus
      compress: true
      errors  : true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.dist}/assets/css"
    .pipe connect.reload()

gulp.task "thirds", ->
  gulp.src path.thirds.css
    .pipe concat "#{pkg.name}.thirds.css"
    .pipe gulp.dest "#{path.dist}/assets/css"
    # .pipe uglify mangle: true
    .pipe connect.reload()

  gulp.src path.thirds.js
    .pipe concat "#{pkg.name}.thirds.js"
    .pipe gulp.dest "#{path.dist}/assets/js"
    # .pipe uglify mangle: true
    .pipe connect.reload()

gulp.task "init", ["source", "style", "thirds"]

gulp.task "default", ->
  gulp.run ["server"]
  gulp.watch path.source, ["source"]
  gulp.watch path.style, ["style"]
