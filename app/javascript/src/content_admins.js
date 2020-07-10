$(document).on('turbolinks:load', function() {
  jQuery(function() {
    var post_url;
    if ($('#content_admins').length) {
      post_url = $('#content_admins').data('sort-items-url');
      return $('#content_admins').sortable({
        axis: 'y',
        handle: '.handle-admin',
        update: function() {
          return $.post(post_url, $(this).sortable('serialize'));
        }
      });
    }
  });

});
