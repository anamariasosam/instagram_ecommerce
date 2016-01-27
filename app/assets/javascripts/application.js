// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require lightbox


function find_product(event) {
  event.preventDefault();
  window.location.href = "/"  + $('.app__search-input').val();
}

function reposition() {
  var modal = $(this),
      dialog = modal.find('.modal-dialog');
  modal.css('display', 'block');

  // Dividing by two centers the modal exactly, but dividing by three
  // or four works better for larger screens.
  dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
}


function add_class_active () {
  var path = window.location.pathname
  if( path == "/catalog/view" || path == "/catalog/flipbook" ){
    $("#home_path").removeClass('active')
    $("#catalog_path").addClass('active')
  } else if ( path == "" ){
    $("#home_path").addClass('active')
    $("#catalog_path").removeClass('active')
  }
}

$(document).on('ready page:change', function() {



  add_class_active()
  $('.app__search-btn').on('click', find_product);
  $('.modal').on('show.bs.modal', reposition);
  $(window).on('resize', function() {
      $('.modal:visible').each(reposition);
  });

});