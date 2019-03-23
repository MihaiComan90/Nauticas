'use strict';

module.exports = {
    init: function () {
        this.toggle();
    },

    toggle: function () {
        var $container = $('#sidebar-left .list-box');
        $container.each(function() {
            var $listHeader = $(this).find('a.list-group-item'),
                $listBody = $(this).find('div.list-group-item');
            $listHeader.off('click').on('click', function() {
                $listBody.slideToggle();
                $(this).toggleClass('active');
            });
        });
    }
}