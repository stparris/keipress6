jQuery(function() {
  var post_url;
  if ($('#page_contents')) {
    post_url = $('#page_contents').data('sort-items-url');
    return $('#page_contents').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
