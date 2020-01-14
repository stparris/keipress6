$(document).ready(function(){
  var post_url;
  if ($('#containers_page').length) {
    post_url = $('#containers_page').data('sort-items-url');
    return $('#containers_page').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
