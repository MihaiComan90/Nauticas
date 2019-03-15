$(document).ready(function(){
    //Do something on document ready
});

$(document).on('change', '#product_variants', function(){
    if($(this).val().length) {
       window.location = $(this).val();
   }
});