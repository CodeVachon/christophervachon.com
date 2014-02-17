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
			file: {
				src: ['gruntfile.js'],
			}
		}, 
		less: {
			build: {
				options: {
				},
				files: {
					"src/css/christophervachon.css": "src/less/christophervachon.less"
				}
			}
		},
		csslint: {
			strict: {
				options: {
					import: 2
				},
				src: ['src/css/*.css']
			}
		},
		cssmin: {
			minify: {
				files: {
					'includes/css/christophervachon.min.css':['src/css/*.css','!src/css/*.min.css']
				}
			}
		},
		watch: {
			scripts: {
				files: ['lib/js/*.js','gruntfile.js'],
				tasks: ['jshint'],
				options: {
					spawn: false,
				}
			},
			less: {
				files: ['src/less/*.less'],
				tasks: ['less:build','csslint:strict','cssmin:minify'],
				options: {
					spawn: false,
				}
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-csslint');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
}; // close module.exports
