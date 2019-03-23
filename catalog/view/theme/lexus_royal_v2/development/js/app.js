'use strict';

var slick = require('./_slick');
var nav = require('./_nav');
var filters = require('./_filters');

$(function(){
    // Mobile navigation
    nav.init();
    // Filters
    filters.init();
    // Slick sliders - homepage
    slick.homepage();
});