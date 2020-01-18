$(document).on('turbolinks:load', function() {
  var post_url;
  if ($('#image_group_items').length) {
    post_url = $('#image_group_items').data('sort-items-url');
    return $('#image_group_items').sortable({
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

