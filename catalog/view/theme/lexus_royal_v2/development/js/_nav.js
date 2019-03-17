'use strict';

var util = require('./util/_util');

module.exports = {
    init: function () {

        if (util.isMobile()) {
            $('#mobile_menu').mmenu({
                "extensions": [
                    "shadow-page",
                    "shadow-panels"
                 ],
                 "iconbar": {
                    "add": true,
                    "top": [
                       "<a href='#/'><i class='fa fa-home'></i></a>",
                       "<a href='#/'><i class='fa fa-user'></i></a>"
                    ],
                    "bottom": [
                       "<a href='#/'><i class='fa fa-twitter'></i></a>",
                       "<a href='#/'><i class='fa fa-facebook'></i></a>",
                       "<a href='#/'><i class='fa fa-linkedin'></i></a>"
                    ]
                 }
            });
        }
    }
}