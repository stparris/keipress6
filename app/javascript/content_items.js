jQuery(function() {
  var post_url;
  if ($('#content_items')) {
    post_url = $('#content_items').data('sort-items-url');
    return $('#content_items').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
