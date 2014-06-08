module.exports = function(grunt) {
	grunt.initConfig({  
		path: require('path'),
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
				src: ['src<%= path.sep %>js<%= path.sep %>*.js'],
			}
		}, // close jshint
		less: {
			options: {},
			cmvbuild: {
				files: {
					"src<%= path.sep %>css<%= path.sep %>christophervachon.css": "src<%= path.sep %>less<%= path.sep %>cmv<%= path.sep %>bootstrap.less"
				}
			},
			cmvVirt: {
				files: {
					"src<%= path.sep %>css<%= path.sep %>cmvVirt.css": "src<%= path.sep %>less<%= path.sep %>cmvVirt<%= path.sep %>master.less"
				}
			}
		}, // close less
		csslint: {
			strict: {
				options: {
					import: 2
				},
				src: ['src<%= path.sep %>css<%= path.sep %>*.css']
			}
		}, // close csslint
		cssmin: {
			cmvminify: {
				files: {
					'includes<%= path.sep %>css<%= path.sep %>christophervachon.min.css':['src<%= path.sep %>css<%= path.sep %>christophervachon.css','!src<%= path.sep %>css<%= path.sep %>*.min.css']
				}
			},
			cmvVirtminify: {
				files: {
					'includes<%= path.sep %>css<%= path.sep %>cmvVirt.min.css':['src<%= path.sep %>css<%= path.sep %>cmvVirt.css','!src<%= path.sep %>css<%= path.sep %>*.min.css']
				}
			}
		}, // close cssmin
		uglify: {
			sourceFiles: {
				files: [{
					expand: true,
					cwd: 'src<%= path.sep %>js<%= path.sep %>',
					src: '**<%= path.sep %>*.js',
					dest: 'includes<%= path.sep %>js'
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
			CMVless: {
				files: ['src<%= path.sep %>less<%= path.sep %>cmv<%= path.sep %>*.less'],
				tasks: ['less:cmvbuild','cssmin:cmvminify'], //,'csslint:strict' -- csslint dosnt play well with bootstrap
				options: {
					spawn: false
				}
			}, // close less
			cmvVirtLess: {
				files: ['src<%= path.sep %>less<%= path.sep %>cmvVirt<%= path.sep %>*.less'],
				tasks: ['less:cmvVirt','cssmin:cmvVirtminify'], //,'csslint:strict' -- csslint dosnt play well with bootstrap
				options: {
					spawn: false
				}
			},
			jsfiles: {
				files: ['src<%= path.sep %>js<%= path.sep %>*.js'],
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
