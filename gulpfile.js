var config = require('./config.json');
var args = require('yargs').argv;
var gulp = require('gulp');
//var watch = require('gulp-watch');
var jade = require('gulp-jade');
var stylus = require('gulp-stylus');
var coffee = require('gulp-coffee');

var level = args.level;

function doHTML(cfg, level){
	console.log('_nivel'+level+cfg.jade.src, '_nivel'+level+cfg.jade.dest);
	return gulp.src('_nivel'+level+cfg.jade.src)
		.pipe(jade({pretty:true}))
		.pipe(gulp.dest('_nivel'+level+cfg.jade.dest));
}
function doCSS(cfg, level){
	console.log(cfg.stylus.src, '_nivel'+level+cfg.stylus.dest);
	return gulp.src(cfg.stylus.src)
	.pipe(stylus())
	.pipe(gulp.dest('_nivel'+level+cfg.stylus.dest));
}
function doCoffee(cfg, level){
	console.log('A cup of coffee on level: ', level);
	console.log(cfg.coffee.src, '_nivel'+level+cfg.coffee.dest);
	return gulp.src(cfg.coffee.src)
	.pipe(coffee())
	.pipe(gulp.dest('_nivel'+level+cfg.coffee.dest));
}

gulp.task('create', function(){
	doHTML(config, level);
	doCSS(config, level);
	doCoffee(config, level);
});

gulp.task('production', function(){
	//gulp.src(['node-webkit/**/*']).pipe(gulp.dest('dist/_nivel'+level));
	gulp.src([
		'_nivel'+level+'/css/**/*.*',
		'_nivel'+level+'/img/**/*.*',
		'_nivel'+level+'/js/**/*.*',
		'_nivel'+level+'/snd/**/*.*',
		'_nivel'+level+'/templates/**/*.*',
		'_nivel'+level+'/unit-tests/**/*.*',
		'_nivel'+level+'/index.html',
		'_nivel'+level+'/main.html',
		//'_nivel'+level+'/package.json'
		], {base: './'})
	.pipe(gulp.dest('dist'));
	console.log('Level '+level+' Complete!');
});

//gulp.task('nw', function(){
//	var date = new Date().toISOString().replace(/[^0-9]/g, '');
//	gulp.src([
//		'_nivel'+level+'/css/**/*',
//		'_nivel'+level+'/img/**/*',
//		'_nivel'+level+'/js/**/*',
//		'_nivel'+level+'/snd/**/*',
//		'_nivel'+level+'/templates/**/*',
//		'_nivel'+level+'/unit-tests/**/*',
//		'_nivel'+level+'/index.html',
//		'_nivel'+level+'/main.html',
//		'_nivel'+level+'/package.json'
//		])
//    .pipe(zip('level-' + level + '-' + date + '.zip'))
//    .pipe(gulp.dest('dist'));
//});
