$(document).on('turbolinks:load', function() {
  var post_url;
  if ($('#container_rows').length) {
    post_url = $('#container_rows').data('sort-items-url');
    return $('#container_rows').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
