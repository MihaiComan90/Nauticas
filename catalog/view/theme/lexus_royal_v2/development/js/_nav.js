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
                       "<a href='/'><i class='fa fa-home'></i></a>",
                       "<a href='#/'><i class='fa fa-user'></i></a>"
                    ],
                    "bottom": [
                       "<a href='mailto:office@nautica-shop.ro'><i class='fa fa-envelope-o'></i></a>",
                       "<a href='tel:0745884878'><i class='fa fa-phone'></i></a>",
                       "<a href='https://www.facebook.com/pages/Nautica-SHOP/569833203045779' title='Nautica Shop'><i class='fa fa-facebook'></i></a>"
                    ]
                 }
            });
        }
    }
}