(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
'use strict';

module.exports = {
    init: function () {
        this.toggleFiltersBox();
        this.toggleFiltersContainerMobile();
    },

    toggleFiltersBox: function () {
        var $container = $('#sidebar-left .list-box');
        $container.each(function() {
            var $listHeader = $(this).find('a.list-group-item'),
                $listBody = $(this).find('div.list-group-item');
            $listHeader.off('click').on('click', function() {
                $listBody.slideToggle();
                $(this).toggleClass('active');
            });
        });
    },

    toggleFiltersContainerMobile: function () {
        var $filterBtn = $('.filter-mobile-heading'),
            $filterContainer = $filterBtn.next();
        
        $filterBtn.on('click', function () {  
            $filterContainer.slideToggle();
        });
    }
}
},{}],2:[function(require,module,exports){
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
},{"./util/_util":5}],3:[function(require,module,exports){
'use strict';

var options = {
    infinite: true,
    slidesToShow: 6,
    slidesToScroll: 1,
    adaptiveHeight: true,
    variableWidth: false, 
    prevArrow:"<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
    nextArrow:"<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>",
    responsive: [
        {
          breakpoint: 1024,
          settings: {
            slidesToShow: 6, 
            slidesToScroll: 3,
            infinite: true,
            dots: false
          }
        },
        {
          breakpoint: 600,
          settings: {
            slidesToShow: 3,
            slidesToScroll: 2
          }
        },
        {
          breakpoint: 480,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        }
      ]
}

module.exports = {
    homepage: function () {
        var $sContainer = $('[id^="productcarousel"]');

        $sContainer.slick(options);
    }
}
},{}],4:[function(require,module,exports){
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
},{"./_filters":1,"./_nav":2,"./_slick":3}],5:[function(require,module,exports){
'use strict';

var util = {
    isMobile: function () {
        var mobileAgentHash = ['mobile', 'tablet', 'phone', 'ipad', 'ipod', 'android', 'blackberry', 'windows ce', 'opera mini', 'palm'];
        var idx = 0;
        var isMobile = false;
        var userAgent = (navigator.userAgent).toLowerCase();

        while (mobileAgentHash[idx] && !isMobile) {
            isMobile = (userAgent.indexOf(mobileAgentHash[idx]) >= 0);
            idx++;
        }
        return isMobile;
    }
}

module.exports = util;
},{}]},{},[4]);

//# sourceMappingURL=app.js.map
