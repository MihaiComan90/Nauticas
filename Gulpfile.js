'use strict';

var browserify = require('browserify'),
  	gulp = require('gulp'),
  	gutil = require('gulp-util'),
  	sass = require('gulp-sass'),
  	minifycss = require('gulp-minify-css'),
  	buffer = require('vinyl-buffer'),
	source = require('vinyl-source-stream'),
	watchify = require('watchify'),
	sourcemaps = require('gulp-sourcemaps'),
	concat = require('gulp-concat'),
	livereload = require('gulp-livereload');

var paths = {
	scss: {
    	src: './catalog/view/theme/lexus_royal_v2/development/**/*.scss',
		dest: './catalog/view/theme/lexus_royal_v2/stylesheet/skins'
  	},
  	js: {
  		src: './catalog/view/theme/lexus_royal_v2/development/js/app.js',
		dest: './catalog/view/theme/lexus_royal_v2/javascript/static/default/js/'
  	}
};

var watching = false;

/* Enable Watch Mode */
gulp.task('enable-watch-mode', function () {
	watching = true;
});

/* Compile SCSS files into one CSS file */
gulp.task('scss', function() {
	gulp
		.src(paths.scss.src)
		.pipe(sourcemaps.init())
		.pipe(sass().on('error', sass.logError))
		.pipe(concat('global.css'))
		.pipe(sourcemaps.write(paths.scss.dest))
		.pipe(gulp.dest(paths.scss.dest))
		.pipe(livereload());
	});
	
	// .pipe(minifycss())
/* Run Browserify on JS files */
gulp.task('js', function() {
	var opts = {
			entries: paths.js.src,
			debug: gutil.env.sourcemaps
		},
		bundler = browserify(opts);
	
	if (watching) {
		bundler = watchify(bundler);
	}
	
	bundler.on('update', function (ids) {
		gutil.log('File(s) changed: ' + gutil.colors.cyan(ids));
		gutil.log('Rebundling...');
		rebundle();
	});
	
	bundler.on('log', gutil.log);
	
	function rebundle () {
		return bundler
			.bundle()
			.on('error', function (e) {
				gutil.log('Browserify Error', gutil.colors.red(e));
			})
			.pipe(source('app.js'))
			// sourcemaps
				.pipe(buffer())
				.pipe(sourcemaps.init({loadMaps: true}))
				.pipe(sourcemaps.write('./'))
			//
			.pipe(gulp.dest(paths.js.dest))
			.pipe(livereload());
	}
	
	return rebundle();
});


/* Watch JS & SCSS */
gulp.task('watch', ['enable-watch-mode', 'js', 'scss'], function () {
	livereload.listen();
	livereload.reload();
	gulp.watch(paths.scss.src, ['scss']);
});

/* Running with no params, builds JS and CSS */
gulp.task('default', ['js', 'scss']);