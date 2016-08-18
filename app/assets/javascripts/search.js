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

/*
  Validates the input value is invalid
  The input must be any word character
  and exactly 5 characters
*/
function validate_search_req( event ) {
  var $input = getInput();
  var patt = new RegExp(/\b[\w+]{5}\b/);

  if ( !patt.test($input.val()) ){
    event.preventDefault();
    $input
      .val('')
      .attr("placeholder", "Verifica el código")
      .parent().addClass('has-error');
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
    $(".js_search-Modalinput").parent().removeClass('has-error')
  });

  // Validate search product box
  $(".js_search-product").on('submit', validate_search_req);
});
