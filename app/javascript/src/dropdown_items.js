$(document).on('turbolinks:load', function() {
  var post_url;
  if ($('#dropdown_items').length) {
    post_url = $('#dropdown_items').data('sort-items-url');
    return $('#dropdown_items').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
