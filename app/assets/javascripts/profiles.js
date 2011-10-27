$(document).ready(function(){
    $('textarea[maxlength]').keyup(function(){
        var max = parseInt($(this).attr('maxlength'));
        if($(this).val().length > max){
            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
        }
        if($(this).val().length > max-50){
          $(this).parent().find('.charsRemaining').html('You have ' + (max - $(this).val().length) + ' characters remaining').fadeIn();
        } else {
          $(this).parent().find('.charsRemaining').fadeOut();  
        }  
    });
});
