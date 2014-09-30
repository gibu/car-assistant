gulp = require('gulp')
coffeeify = require('gulp-coffeeify')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
sass = require('gulp-sass')
nodemon = require('gulp-nodemon')
gutil = require('gutil')
watch = require('gulp-watch')
coffeelint = require('gulp-coffeelint')
# svgSymbols = require('gulp-svg-symbols')
paths =
  ignore: ['assets/**', 'public/**', '.sass-cache/**', 'examples/**', 'extensions/**', 'migrations/**', 'node_modules/**', 'spec/**', 'styles/**', 'tmp/**', 'tools/**']
  coffeelint:
    src: ['*.coffee','app/*/*.coffee', 'assets/js/**/*.coffee']

gulp.task 'coffeelint', () ->
  gulp.src(paths.coffeelint.src)
  .pipe(coffeelint(max_line_length: { level: 'ignore' }))
  .pipe(coffeelint.reporter())

gulp.task 'nodemon', () ->
  nodemon({ script: './server.coffee', ext: 'coffee js', ignore: paths.ignore})
    .on('start', ['watch'])
    .on('change', ['watch'])

gulp.task 'watch', () ->
  console.log "watch task"

# gulp.task('default', ['nodemon'])
gulp.task 'default', ['nodemon']