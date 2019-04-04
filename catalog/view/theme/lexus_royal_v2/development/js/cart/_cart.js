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
