$(document).ready(function(){
  var post_url;
  if ($('#list_group_items').length) {
    post_url = $('#list_group_items').data('sort-items-url');
    return $('#list_group_items').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
