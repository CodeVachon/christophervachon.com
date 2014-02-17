module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		jshint: {
			options: {
				globals: {
					jQuery: true,
					console: true,
					module: true
				} // close .globals
			}, // close .options
			gruntfile: {
				src: ['gruntfile.js'],
			},
			sourceFiles: {
				src: ['src/js/*.js'],
			}
		}, // close jshint
		less: {
			build: {
				options: {
				},
				files: {
					"src/css/christophervachon.css": "src/less/christophervachon.less"
				}
			}
		}, // close less
		csslint: {
			strict: {
				options: {
					import: 2
				},
				src: ['src/css/*.css']
			}
		}, // close csslint
		cssmin: {
			minify: {
				files: {
					'includes/css/christophervachon.min.css':['src/css/*.css','!src/css/*.min.css']
				}
			}
		}, // close cssmin
		uglify: {
			sourceFiles: {
				files: [{
					expand: true,
					cwd: 'src/js/',
					src: '**/*.js',
					dest: 'includes/js'
				}]
			}
		}, // close uglify
		watch: {
			gruntfile: {
				files: ['gruntfile.js'],
				tasks: ['jshint:gruntfile'],
				options: {
					spawn: false
				}
			}, // close gruntfile
			less: {
				files: ['src/less/*.less'],
				tasks: ['less:build','csslint:strict','cssmin:minify'],
				options: {
					spawn: false
				}
			}, // close less
			jsfiles: {
				files: ['src/js/*.js'],
				tasks: ['jshint:sourceFiles','uglify:sourceFiles'],
				options: {
					spawn: false
				}
			} // close jsfiles
		} // close watch
	});

	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-csslint');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
}; // close module.exports
