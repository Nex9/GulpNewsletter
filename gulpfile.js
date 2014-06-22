var gulp = require('gulp'),
	gutil = require('gulp-util'),
	notify = require('gulp-notify'),
	autoprefix = require('gulp-autoprefixer'),
	inline = require('gulp-inline-css'),
	less = require('gulp-less'),
	path = require('path'),
	rename = require('gulp-rename');

var cssDir = './src/css/';
var targetCssDir = './compiled/css/';

var rawHtml = './src/index.html';
var newHtml = './compiled/index-external.html';
var targetHtml = './compiled/';

gulp.task('css', function(){
	// Compile less and autoprefix
	return gulp.src(cssDir + 'main.less')
			.pipe(less({
				paths: [ path.join(__dirname, 'less', 'includes')]
			})).on('error', gutil.log)
			.pipe(autoprefix('last 20 version'))
			.pipe(gulp.dest(targetCssDir))
			.pipe(notify('LESS compiled and minified'));
});

gulp.task('copy', ['css'], function(){
	// Copy raw html-file
	return gulp.src(rawHtml)
			.pipe(rename('index-external.html'))
			.pipe(gulp.dest(targetHtml));
});

gulp.task('html', ['copy'], function(){
	// Make inline html-file
	return gulp.src(newHtml)
			.pipe(inline({
				applyStyleTags: false,
				removeStyleTags: false
			})).on('error', gutil.log)
			.pipe(rename('index-inline.html'))
			.pipe(gulp.dest(targetHtml))
			.pipe(notify('CSS inlined'));
});

gulp.task('watch', function(){
	gulp.watch(['./src/*', './src/css/*'], ['css', 'copy', 'html']);
});