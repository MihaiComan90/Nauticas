'use strict';

var slick = require('./_slick');
var nav = require('./_nav');
var filters = require('./_filters');
var cart = require('./cart/_cart');
var quickView = require('./_quickview');

$(function(){
    // Mobile navigation
    nav.init();
    // Filters
    filters.init();
    // Slick sliders - homepage
    slick.homepage();
    // Product page
    cart.init();
    // Quick View
    //quickView.init();
});