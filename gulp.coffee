gulp        = require("gulp")
browserSync = require 'browser-sync'
reload      = browserSync.reload

gutil       = require("gulp-util")
notify      = require("gulp-notify")
prefix      = require("gulp-autoprefixer")
inline      = require("gulp-inline-css")
sass        = require 'gulp-ruby-sass'
path        = require("path")
rename      = require("gulp-rename")
fileinclude = require('gulp-file-include')
modRewrite  = require 'connect-modrewrite'




cssDir       = "./src/css/"
targetCssDir = "./compiled/css/"
rawHtml      = "./src/index.html"
newHtml      = "./compiled/index.html"
targetHtml   = "./compiled/"


gulp.task 'bs-reload', ->
  browserSync.reload()

gulp.task "css", ->

  # Compile less and autoprefix
  gulp.src(cssDir + "index.sass")
    .pipe sass()
    .pipe prefix("last 20 versions")
    .pipe gulp.dest(targetCssDir)
    .pipe notify("SASS compiled and minified")
    .pipe reload()

gulp.task "fileinclude", ->
  gulp.src(rawHtml)
    .pipe fileinclude prefix: '@@'
    .pipe gulp.dest(targetHtml)


gulp.task "copy", ["css"], ->
  gulp.src(rawHtml)
    .pipe rename("index-external.html")
    .pipe gulp.dest(targetHtml)


gulp.task "html", ["fileinclude"], ->

  # Make inline html-file
  gulp.src(newHtml)
    .pipe(inline(applyStyleTags: false, removeStyleTags: false))
    .pipe rename("index-inline.html")
    .pipe gulp.dest(targetHtml)
    .pipe notify("CSS inlined")
    .pipe reload()


gulp.task 'browser-sync', ->
  browserSync.init ["./compiled/index.html"],
    server:
      baseDir: "./"
    startPath: "/compiled/index.html"


# gulp.task 'prepare', ['css', 'fileinclude', 'html'], ->


gulp.task "watch", ['css', 'fileinclude', 'html', 'browser-sync'], ->
  gulp.watch [
    "./src/*"
    "./src/css/*"
    "./src/widgets/*"
  ]
  gulp.watch("*.html", ['fileinclude', 'html'])
  gulp.watch("*.css", ['css', 'fileinclude'])
