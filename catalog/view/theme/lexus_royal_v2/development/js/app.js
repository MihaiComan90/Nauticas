'use strict';

var slick = require('./_slick');
var nav = require('./_nav');

$(function(){
    // Mobile navigation
    nav.init();
    // Slick sliders - homepage
    slick.homepage();
});