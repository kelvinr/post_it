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

$(document).ready(function(){
  category();
  forms();
  info();
});

$(document).on('page:load', function(){
  category();
  forms();
  info();
});

function category() {
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

function forms () {
  $('.remote').click(function(event){
    var form = $(this).next('.form');
    if ($(this).hasClass("vis")){
      form.slideToggle();
      event.stopPropagation();
      event.preventDefault();
    if (form.hasClass('log') && $('.new').css('display') == 'flex'){
      $('.new').slideToggle();
    } else if (form.hasClass('new') && $('.log').css('display') == 'flex'){
      $('.log').slideToggle();}
    }
    $(this).addClass("vis");
  });
}

function info() {
  $('.container-fluid').on('click', 'i', function(){
    $('.dark_well').slideToggle();
  });
}