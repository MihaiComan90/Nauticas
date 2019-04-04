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
},{"./util/_util":7}],3:[function(require,module,exports){
'use strict';
/** 
 * TO DO: need works
*/

module.exports = {
    init: function() {
        this.show();
        this.close();
    },
    show: function() {
        var $quickviewBtn = $('.product-block .quick-view');

        $quickviewBtn.off('click').on('click', function(e){
            e.preventDefault();
            $('#QuickView').remove();
            var url = $(this).attr('href');
            
            console.log(url);
            $.ajax({
                url : url,
                type: 'get',
                success: function(data){
                    var htmlString = 
                    '<div class="modal" id="QuickView" role="dialog">' + 
                        '<div class="modal-dialog modal-dialog-centered">' +
                            '<div class="modal-content">' +
                                '<div class="modal-header">' + 
                                    '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
                                    '<h4>QuickView Header</h4>' +
                                '</div>' +
                                '<div class="modal-body">' +
                                    data +
                                '</div>'
                            '</div>' + 
                        '</div>' +
                    '</div>'
                    $('body').append(htmlString);
                }
            })
            $('#QuickView').modal('show');
        });
    },
    close: function() {
      
        $(document).on('hide.bs.modal','#QuickView', function () {
            $('#QuickView').remove();
        });
    }
};
},{}],4:[function(require,module,exports){
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
},{}],5:[function(require,module,exports){
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
},{"./_filters":1,"./_nav":2,"./_quickview":3,"./_slick":4,"./cart/_cart":6}],6:[function(require,module,exports){
'use strict';

module.exports = {
    init : function () {
        this.addToCart();
        this.removeProductFromMiniCart();
    },

    addToCart : function () {
        var $addToCart = $('#button-cart'),
            url = $addToCart.data('url');

        $addToCart.on('click', function() {
            $.ajax({
                url: url,
                type: 'post',
                data: $('#product input[type=\'number\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-cart').button('loading');
                },
                complete: function() {
                    $('#button-cart').button('reset');
                },
                success: function(json) {
                    $('.alert, .text-danger').remove();
                    $('.form-group').removeClass('has-error');
                    if (json['error']) {
                        if (json['error']['option']) {
                            for (i in json['error']['option']) {
                                var element = $('#input-option' + i.replace('_', '-'));
                                if (element.parent().hasClass('input-group')) {
                                    element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                                } else {
                                    element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                                }
                            }
                        }
                        if (json['error']['recurring']) {
                            $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                        }
                        // Highlight any found errors
                        $('.text-danger').parent().addClass('has-error');
                    }
                    if (json['success']) {
                        $('#notification').html('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        $('#cart-total sup').html(json['totalQty']);
                        $('html, body').animate({ scrollTop: 0 }, 'slow');
                        $('#minicart-container').load('index.php?route=common/cart/info');
                    }
                }
            });
        });
    },

    removeProductFromMiniCart : function () {
        var key, url;
        $('body').on('click', '.minicart button.remove', function(){
            key = $(this).data('key');
            url = $(this).data('url');

            $.ajax({
                url: url,
                type: 'post',
                data: 'key=' + key,
                dataType: 'json',
                beforeSend: function() {
                    $('#cart > button').button('loading');
                },
                success: function(json) {
                    $('#cart > button').button('reset');
            
                    $('#cart-total').html(json['total']);
            
                    if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                        location = 'index.php?route=checkout/cart';
                    } else {
                        $('#minicart-container').load('index.php?route=common/cart/info');
                    }
                }
            });
        })
    }
}

},{}],7:[function(require,module,exports){
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
},{}]},{},[5]);

//# sourceMappingURL=app.js.map
