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

// Validates the input value is not empty
function validate_search_req( event ) {
  var $input = getInput();
  if ( !$input.val() ) {
    event.preventDefault();
    $input
      .attr("placeholder", "Recuerda escribir el código de producto");
  }
}

$(document).on('ready page:change page:load', function() {
  $('#searchModal').on('show.bs.modal', center_modal);
  $(window).on('resize', function() {
      $('.modal:visible').each(center_modal);
  });

  $('#searchModal').on('hidden.bs.modal', function () {
    $(".app__search-input").parent().removeClass('has-error')
  });

  // Validate search product box
  $(".js_search-product").on('submit', validate_search_req);
});
