import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'bootstrap/dist/js/bootstrap';

import jQueryBridget from 'jquery-bridget';
import Masonry from 'masonry-layout';
import imagesLoaded from 'imagesloaded/imagesloaded';

// jQuery ($), Popper imported via webpack/environment.js

initialize();

function initialize() {
  Rails.start();
  Turbolinks.start();

  // make Masonry a jQuery plugin
  jQueryBridget('masonry', Masonry, $); // now you can use $().masonry()

  // provide jQuery argument
  imagesLoaded.makeJQueryPlugin($); // now use .imagesLoaded() jQuery plugin
}

$(document).on('turbolinks:load', function() { // equivalent of $(document).ready()
  console.log('JS loaded.')
  addSpace();
  var $grid = initMasonry();

  // layout Masonry after each image loads
  $grid.imagesLoaded().progress( function() {
    $grid.masonry('layout');
  });
});

function initMasonry() {
  return $('.masonry-grid').masonry({ // returns the jquery masonry grid to be stored as a variable
    // options
    itemSelector: '.card',
    // columnWidth: 280, // with no columnWidth set, will take size of first element in grid
    horizontalOrder: true,
    isFitWidth: true,  // breaks columns like media queries
    gutter: 20,
    transitionDuration: '0.3s'
  });
}

function addSpace() {
  var spaceBetween = $('.custom-footer').offset().top - $('.navbar').offset().top; // get space between header and footer
  var target = 600;

  if (spaceBetween < target) { // if space between header and footer < x
    var numOfSpaces = (target - spaceBetween) / 35;

    for(var i = 0; i < numOfSpaces; i++) {
      $('#main-container').append('<p>&nbsp</p>'); // add space above footer
    }
  }
}
