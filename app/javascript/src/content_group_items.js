$(document).on('turbolinks:load', function() {
  var post_url;
  if ($('#content_group_items').length) {
    post_url = $('#content_group_items').data('sort-items-url');
    return $('#content_group_items').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
