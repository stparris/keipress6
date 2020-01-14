$(document).ready(function(){
  var post_url;
  if ($('#carousel_slides').length) {
    post_url = $('#carousel_slides').data('sort-items-url');
    return $('#carousel_slides').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
  
  $('.carousel').carousel({
    interval: 2000
  });

});

