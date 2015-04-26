"use strict"

# -- DEPENDENCIES --------------------------------------------------------------
gulp    = require "gulp"
cjsx    = require "gulp-cjsx"
concat  = require "gulp-concat"
connect = require 'gulp-connect'
header  = require "gulp-header"
gutil   = require "gulp-util"
uglify  = require "gulp-uglify"
stylus  = require "gulp-stylus"
pkg     = require "./package.json"

# -- FILES ---------------------------------------------------------------------
path =
  dist      :   "./dist/assets"
  cjsx      : [ "source/entities/*.coffee"
                "source/components/app.*.cjsx"
                "source/components/app.cjsx"]
  styl      : [ "source/styles/*.styl"]
  js        : [ "bower_components/react/react.min.js"
                "bower_components/hamsa/dist/hamsa.js"
                "bower_components/moment/min/moment.min.js"
                ]

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
gulp.task "webserver", ->
  connect.server
    port      : 8000
    livereload: true

gulp.task "cjsx", ->
  gulp.src path.cjsx
    .pipe concat "#{pkg.name}.cjsx"
    .pipe cjsx().on "error", gutil.log
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.dist}/js"
    .pipe uglify mangle: true
    .pipe connect.reload()

gulp.task "styl", ->
  gulp.src path.styl
    .pipe concat "#{pkg.name}.styl"
    .pipe stylus
      compress: true
      errors  : true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.dist}/css"
    .pipe connect.reload()

gulp.task "js", ->
  gulp.src path.js
    .pipe concat "#{pkg.name}.dependencies.js"
    .pipe gulp.dest "#{path.dist}/js"
    .pipe connect.reload()

gulp.task "init", ["cjsx", "styl", "js"]

gulp.task "default", ->
  gulp.run ["webserver"]
  gulp.watch path.cjsx, ["cjsx"]
  gulp.watch path.styl, ["styl"]
