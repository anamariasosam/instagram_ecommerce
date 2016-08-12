function showGif() {
  var url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=happy"
  $.get( url, function( data ) {
    $('#js_celebrateGif').attr('src', data.data.image_url);
  });
}

$(document).on('ready', function() {
  if ($('#js_celebrateGif').length) {
    showGif()
  }
});
