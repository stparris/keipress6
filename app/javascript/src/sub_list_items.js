jQuery(function() {
  var post_url;
  if ($('#sublist_items')) {
    post_url = $('#sublist_items').data('sort-items-url');
    return $('#sublist_items').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
