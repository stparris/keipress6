$(document).ready(function(){
  var post_url;
  if ($('#row_columns').length) {
    post_url = $('#row_columns').data('sort-items-url');
    return $('#row_columns').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }	
});
