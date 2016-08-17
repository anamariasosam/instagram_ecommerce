// Set modal in the center of the view
function center_modal() {
  var modal = $(this),
      dialog = modal.find('.modal-dialog');
  modal.css('display', 'block');

  // Dividing by two centers the modal exactly, but dividing by three
  // or four works better for larger screens.
  dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
}

// Select the input between the modal input and the intro input
function getInput() {
  if ($('#searchModal').is(':visible')) {
    return $(".js_search-Modalinput")
  } else {
    return $(".js_search-input")
  }
}

// Validates the input value is empty or invalid
function validate_search_req( event ) {
  var $input = getInput();
  var patt = new RegExp(/^[a-zA-Z0-9]+$/);

  if ( !patt.test($input.val()) && $input.val().length != 5){
    event.preventDefault();
    $input
      .val('')
      .attr("placeholder", "Verifica el código");
  }
}

$(document).on('ready page:change page:load', function() {
  $('#searchModal').on('shown.bs.modal', function() {
    center_modal()
    $(this).find('[autofocus]').focus();
  });

  $(window).on('resize', function() {
      $('.modal:visible').each(center_modal);
  });

  $('#searchModal').on('hidden.bs.modal', function () {
    $(".app__search-input").parent().removeClass('has-error')
  });

  // Validate search product box
  $(".js_search-product").on('submit', validate_search_req);
});
