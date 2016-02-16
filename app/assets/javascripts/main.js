function find_product(event) {
  event.preventDefault();
  window.location.href = "/"  + $('.app__search-input').val().toLowerCase();
}

function description_text (argument) {
  if ($('.app__product-description')) {
    $('.app__product-description').next().css( "word-wrap", "break-word" );
  }
}

// Set modal in the center of the view
function center_modal() {
  var modal = $(this),
      dialog = modal.find('.modal-dialog');
  modal.css('display', 'block');

  // Dividing by two centers the modal exactly, but dividing by three
  // or four works better for larger screens.
  dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
}

// Add class active to menu
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

// Collapse menu on click
$(".navbar-nav li a").click(function (event) {
  var toggle = $(".navbar-toggle").is(":visible");
  if (toggle) {
    $(".navbar-collapse").collapse('hide');
  }
});


$('#logout').on('click', function(event) {
    event.preventDefault();
    window.open("https://www.instagram.com/accounts/logout/");
});

$('.app__search-btn').on('click', find_product);

$('.modal').on('show.bs.modal', center_modal);

$(window).on('resize', function() {
    $('.modal:visible').each(center_modal);
});

$(document).on('ready page:change', function() {
  add_class_active();
  description_text();
});