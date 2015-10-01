module.exports = function () {
    "use strict";

    return {
        less: {
            files: ['less/**', 'color.yml'],
            tasks: ['csslint', 'less-compile']
        },
        js: {
            files: ['js/**', 'components.json'],
            tasks: ['dev-js']
        }
    };
};