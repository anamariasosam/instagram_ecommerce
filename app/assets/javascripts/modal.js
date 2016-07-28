// Set modal in the center of the view
function center_modal() {
  var modal = $(this),
      dialog = modal.find('.modal-dialog');
  modal.css('display', 'block');

  // Dividing by two centers the modal exactly, but dividing by three
  // or four works better for larger screens.
  dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
}

$(document).on('ready page:change page:load', function() {
  $('#loginModal').on('show.bs.modal', center_modal);
  $(window).on('resize', function() {
      $('.modal:visible').each(center_modal);
  });
});
