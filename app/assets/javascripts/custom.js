$(function(){
  $(".btn-warning").on('click', function(event){
    if ($(this).hasClass("vis")){
    event.stopPropagation();
    event.preventDefault();
  }
    $(this).addClass("vis");
    $("#signupform").slideToggle();
  });
});