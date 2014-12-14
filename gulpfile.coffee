gulp = require "gulp"
folderToc = require "folder-toc"
$ = require("gulp-load-plugins")()


gulp.task "build", ->
	gulp.src ["src/*", "!src/*.spec.coffee"]
		.pipe $.changed "bin"
		.pipe $.coffee()
		.pipe gulp.dest "bin"
	gulp.src "index.coffee"
		.pipe $.coffee()
		.pipe gulp.dest "."


gulp.task "test", ->
	gulp.src "src/*.spec.coffee"
		.pipe $.jasmine
			noColor: true
			coffee: true


gulp.task "docs", ->
	gulp.src "src/*"
		.pipe $.changed "docco"
		.pipe $.docco
			layout: "parallel"
		.pipe gulp.dest "docco"
	folderToc "docco",
		filter: "*.html"

gulp.task "docs-codo", ->



gulp.task "default", ["build", "test", "docs"]
