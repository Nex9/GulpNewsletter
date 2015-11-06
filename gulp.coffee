gulp        = require('gulp')
browserSync = require 'browser-sync'

gutil       = require('gulp-util')
notify      = require('gulp-notify')
prefix      = require('gulp-autoprefixer')
inline      = require('gulp-inline-css')
sass        = require 'gulp-sass'
path        = require('path')
rename      = require('gulp-rename')
fileinclude = require('gulp-file-include')
modRewrite  = require 'connect-modrewrite'
watch        = require 'gulp-watch'

cssDir       = './src/css/'
targetCssDir = './compiled/css/'
rawHtml      = './src/index.html'
newHtml      = './compiled/index.html'
targetHtml   = './compiled/'


gulp.task 'bs-reload', ->
  browserSync.reload()

# Compile less and autoprefix
gulp.task 'sass', ->
  gulp.src('./src/css/*.sass')
    .pipe sass({indentedSyntax: true, quiet: true})
    .pipe prefix('last 20 versions')
    .pipe gulp.dest('./compiled/css')
    # .pipe notify('SASS compiled and minified')
    .pipe(browserSync.reload({stream:true}))

# copy media-queries into index.html
gulp.task 'fileinclude', ['sass'], ->
  gulp.src(rawHtml)
    .pipe fileinclude prefix: '@@', basepath: './'
    .pipe gulp.dest(targetHtml)
    .pipe(browserSync.reload({stream:true}))


# gulp.task 'copy', ['sass'], ->
#   gulp.src(rawHtml)
#     .pipe rename('index-external.html')
#     .pipe gulp.dest(targetHtml)


# Make inline html-file
gulp.task 'inlineCss', ['fileinclude'], ->
  gulp.src(newHtml)
    .pipe(inline(applyStyleTags: false, removeStyleTags: false))
    .pipe rename('index-inline.html')
    .pipe gulp.dest(targetHtml)
    .pipe notify('CSS inlined')
    # .pipe(browserSync.reload({stream:true}))


gulp.task 'browser-sync', ->
  browserSync.init ['./compiled/index.html'],
    server:
      baseDir: './'
    startPath: '/compiled/index.html'
    debugInfo: false
    notify: false


gulp.task 'prepare', ['inlineCss'], (next) ->
  next()


gulp.task 'default', ['prepare', 'browser-sync'], ->
  gulp.watch('./src/index.html', ['inlineCss'])
  gulp.watch('./src/css/index.sass', ['sass'])
  gulp.watch('./src/css/media-queries.sass', ['fileinclude'])
