function description_text () {
  if ($('.app__product-description')) {
    $('.app__product-description').next().css( "word-wrap", "break-word" );
  }
}

// Add class active to menu
function add_class_active() {
  var path = window.location.pathname
  if( path == "/catalog/view" ){
    $("#home_path").removeClass('active')
    $("#catalog_path").addClass('active')
  } else if ( path == "" ){
    $("#home_path").addClass('active')
    $("#catalog_path").removeClass('active')
  }
}

// Collapse menu on click
$(".navbar-nav li a").click(function () {
  var toggle = $(".navbar-toggle").is(":visible");
  if (toggle) {
    $(".navbar-collapse").collapse('hide');
  }
});

$(document).on('ready page:change page:load', function() {
  add_class_active();
  description_text();


  $('#logout').on('click', function() {
    window.open("https://www.instagram.com/accounts/logout/");
  });
});
