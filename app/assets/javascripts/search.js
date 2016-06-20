// Set modal in the center of the view
function center_modal() {
  var modal = $(this),
      dialog = modal.find('.modal-dialog');
  modal.css('display', 'block');

  // Dividing by two centers the modal exactly, but dividing by three
  // or four works better for larger screens.
  dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
}

// Validates the input value is not empty
function validate_search_req( event ) {
  var $input = $(".app__search-input");
  if ( !$input.val() ) {
    event.preventDefault();
    $input
      .attr("placeholder", "Recuerda escribir el código de producto");
  }
}

// Open the modal on first page load
function openModalFirstTime() {

  if (Cookies.get('modal_shown') == null) {
    Cookies.set('modal_shown', 'yes', { expires: 1, path: '/' });
    $('#searchModal').modal('show');
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

  // openModalFirstTime();

  // Validate search product box
  $("#app__search-product").on('submit', validate_search_req);
});
