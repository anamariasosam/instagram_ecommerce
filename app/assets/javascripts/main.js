var auto_close_alerts = function () {
  var $alertElement = $(".alert-dismissible")
    .fadeTo(6000, 500)
    .slideUp(500, function(){ $alertElement.alert('close'); });
}

function description_text () {
  if ($('.app__product-description')) {
    $('.app__product-description').next().css( "word-wrap", "break-word" );
  }
}

// Add class active to menu
function add_class_active() {
  var path = window.location.pathname
  $(".menu_nav-item").removeClass('active')
  switch (path) {
    case "/":
      $("#home_path").addClass('active')
      break;
    case "":
      $("#home_path").addClass('active')
      break;
    case "/tutorial/index":
      $("#tutorial_path").addClass('active')
      break;
    case "/users/dashboard":
      $("#user_path").addClass('active')
      $("#add__product_path").addClass('active')
      break;
    case "/products":
      $("#user_path").addClass('active')
      $("#product_path").addClass('active')
      break;
    case "/users/edit":
      $("#user_path").addClass('active')
      $("#edit_user_path").addClass('active')
      break;
    default:
      $("#catalog_path").addClass('active')
  }
}


// Collapse menu on click
$(".navbar-nav li a").click(function () {
  var toggle = $(".navbar-toggle").is(":visible");
  if (toggle) {
    $(".navbar-collapse").collapse('hide');
  }
});


function countdown_for_product_name() {
  var $field = $('.js_countdown_product_name');
  var isInput = $field.prev().is(':input');
  var $input = isInput ? $field.prev() : $field.prev().children('input');
  var remain = $input.val().length;
  $field.text(parseInt(40 - remain, 10));
  addColor(remain);

  $input.on('keyup', function(event) {
    event.preventDefault();
    remain = $input.val().length;
    $field.text(parseInt(40 - remain, 10));
    addColor(remain);
  });
}

function addColor(remain) {
  if (remain < 40) {
    $('#basic-addon2').addClass('success')
  } else {
    $('#basic-addon2').addClass('error');
  }
}

function menuCaret() {
  $('.dropdown').on('show.bs.dropdown', function(){
       $("#app__menu_caret").css('transform', 'rotate(0deg)');
   });
   $('.dropdown').on('hide.bs.dropdown', function(e){
       $("#app__menu_caret").css('transform', 'rotate(270deg)');
   });
}

$(document).on('ready page:change page:load', function() {
  add_class_active();
  description_text();
  auto_close_alerts();
  menuCaret();
  if ($('.major h2').text() == "Editar Producto" || $('.major h2').text() == "Nuevo Producto") {
    countdown_for_product_name();
  }
});
