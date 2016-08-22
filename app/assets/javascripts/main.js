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
  var $list = $(".js_topMenu").find('li');
  var len = $list
    .find('[href="' + path + '"]')
    .addClass('active').length

  if (!len) $list.removeClass('active');
}

function toggleFooterLinks() {
  var $help = $('.js_footerHelp');
  var $links = $('.js_footerInfo').slideUp();

  $help.on('click', function(){
    $links.slideToggle(200);
    $help
      .toggleClass('fa-question-circle')
      .addClass('fa-times-circle');
    $("html, body").animate({
      scrollTop: $(document).height()
    }, 400);
  });
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
    $('#basic-addon2').removeClass('error')
    $('#basic-addon2').addClass('success');

  } else {
    $('#basic-addon2').removeClass('success');
    $('#basic-addon2').addClass('error');
  }
}

function sortProducts() {
  $form = $('#js_productSearch');
  $input = $('#js_searchField');

  function searchAJAXY (event) {
    event.preventDefault();
    var cleanData;

    $input.val($input.val().trim())
    cleanData = $form.serialize().replace(/%5C/g, '');
    $.get($form.attr('action'), !$input.val() ? '' : cleanData, null, "script");
  };

  $input.on('keyup', searchAJAXY);
  $form.on('submit', searchAJAXY);
}

function loader() {
  function addLoaderClass() {
    $('.loader')
      .removeClass('loader--running')
      .addClass('loader--running');
  }

  $('.js_instagramLoad').on('click', addLoaderClass);
  $('.js_nextOnDash').on('click', addLoaderClass);
}

function loadFiraFont() {
  WebFontConfig = {
  google: { families: [ 'Open+Sans:400,700' ] }
};

(function() {
  var wf = document.createElement('script');
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
  wf.type = 'text/javascript';
  wf.async = 'true';
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(wf, s);
})();
}

$(document).on('ready page:load', function() {
  loader();
  add_class_active();
  description_text();
  auto_close_alerts();
  loadFiraFont();
  toggleFooterLinks();

  if ($('.js_countdown_product_name').length) {
    countdown_for_product_name();
  }

  if ($(".pagination").length) {
    $(".pagination").rPage();
  }

});

$(document).on('ready page:load', sortProducts);
