"use strict";

$(document).on("turbolinks:load", function() { //equivalent of $(document).ready()
  addSpace();
});

function addSpace() {
  var spaceBetween = $(".custom-footer").offset().top - $(".navbar").offset().top; //get space between header and footer
  var target = 600;

  if (spaceBetween < target) { //if space between header and footer < x
    var numOfSpaces = (target - spaceBetween) / 35;

    for(var i = 0; i < numOfSpaces; i++) {
      $("#main-container").append("<p>&nbsp</p>"); //add space above footer
    }
  }
}
