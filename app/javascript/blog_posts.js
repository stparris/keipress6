$(document).ready(function(){
  var post_url;
  if ($('#blog_posts').length) {
    post_url = $('#blog_posts').data('sort-items-url');
    return $('#blog_posts').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});

