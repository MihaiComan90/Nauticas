module.exports = function(grunt) {
    grunt.initConfig({
      less: {
        development: {
          options: {
            compress: false,
            yuicompress: false,
            optimization: 2
          },
          files: {
            "catalog/view/theme/lexus_royal_v2/stylesheet/skins/blue.css": "catalog/view/theme/lexus_royal_v2/development/less/skins/black/blue.less" // destination file and source file
          }
        }
      },
      watch: {
        styles: {
          files: ['catalog/view/theme/lexus_royal_v2/development/less/**/*.less'], // which files to watch
          tasks: ['less'],
          options: {
            nospawn: true
          }
        }
      }
    });
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.registerTask('default', ['less', 'watch']);
  };