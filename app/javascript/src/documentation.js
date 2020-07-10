$(document).on('turbolinks:load', function() {
  $(".top-link").on("click", function() {
    $('html, body').animate({
      scrollTop: $('body').offset().top
    }, 200);
  });
  $(".toc-link").on("click", function(e) {
    let link_id = e.target.id;
    $('html, body').animate({
      scrollTop: $('#'+link_id.split('-')[1]).offset().top
    }, 200);
  });
});

$(document).ready(function(){
  $(".top-link").on("click", function() {
    $('html, body').animate({
      scrollTop: $('body').offset().top
    }, 200);
  });
  $(".toc-link").on("click", function(e) {
    let link_id = e.target.id;
    $('html, body').animate({
      scrollTop: $('#'+link_id.split('-')[1]).offset().top
    }, 200);
  });
});
