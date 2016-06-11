function changeToAnchor() {
  var userAgent = navigator.userAgent || navigator.vendor || window.opera;

  if( userAgent.match( /Android/i ) )
  {
    $('#phone_number').replaceWith(function() {
      var url = $.trim($(this).text());
      return '<a '
                + 'href="intent://send/573155533091#Intent;scheme=smsto;package=com.whatsapp;action=android.intent.action.SENDTO;end">'
                + url
                + '</a>';
    });
  }
}

$(document).on('ready page:change page:load', function() {
  changeToAnchor();
});
