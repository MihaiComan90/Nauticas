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