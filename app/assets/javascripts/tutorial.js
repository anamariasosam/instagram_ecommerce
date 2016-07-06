//= require viewportchecker/viewportchecker.js

var viewportOptions = {
  classToAdd: 'visible', // Class to add to the elements when they are visible,
  classToAddForFullView: 'full-visible', // Class to add when an item is completely visible in the viewport
  classToRemove: 'invisible', // Class to remove before adding 'classToAdd' to the elements
  removeClassAfterAnimation: false, // Remove added classes after animation has finished
  offset: '20%', // The offset of the elements (let them appear earlier or later). This can also be percentage based by adding a '%' at the end
  invertBottomOffset: true, // Add the offset as a negative number to the element's bottom
  repeat: false, // Add the possibility to remove the class if the elements are not visible
  scrollHorizontal: false // Set to true if your website scrolls horizontal instead of vertical.
}

$(document).on('ready page:change page:load', function() {
  $('.tutorial__instructions').viewportChecker(viewportOptions);
  $('.tutorial__headline').viewportChecker($.extend( viewportOptions, {offset: '5%'} ));
  $('.tutorial__video').viewportChecker($.extend( viewportOptions, {offset: '20%'} ));
});
