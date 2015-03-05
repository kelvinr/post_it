// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

var form;
form = function() {
  $('.remote').click(function(event){
    if ($(this).hasClass("vis")){
      event.stopPropagation();
      event.preventDefault();
      $(this).next(".form").slideToggle();
    }
    $(this).addClass("vis");
    });
  $('.container-fluid').on('click', 'i', function(){
    $('.dark_well').slideToggle();
  });
}
$(document).ready(form);
$(document).on('page:load', form);

var category;
category = function() {
  $(".cat").on('click', function(event){
    if ($(this).hasClass("vis")){
      event.stopPropagation();
      event.preventDefault();
      $("#newcat").slideToggle();
    }
    $(this).closest('.btn-group').removeClass('open');
    $(this).closest('.btn-info').attr('aria-expanded', 'false');
    $(this).addClass("vis");
  });
}
$(document).ready(category);
$(document).on('page:load', category);