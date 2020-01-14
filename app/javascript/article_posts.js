$(document).ready(function(){
  var post_url;
  if ($('#article_posts').length) {
    post_url = $('#article_posts').data('sort-items-url');
    return $('#article_posts').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});