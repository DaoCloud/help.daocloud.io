#!/usr/bin/env node

var Imagemin = require('imagemin');

new Imagemin()
    .src('src/img/**/*.{png,svg}')
    .dest('dist/img')
    .use(Imagemin.optipng({optimizationLevel: 2}))
    .run();
