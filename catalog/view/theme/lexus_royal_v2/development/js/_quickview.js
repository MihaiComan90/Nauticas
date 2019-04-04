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