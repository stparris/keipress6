$(document).on('turbolinks:load', function() {
  var post_url;
  if ($('#rental_payment_method').length) {
    post_url = $('#rental_payment_method').data('sort-items-url');
    return $('#rental_payment_method').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post(post_url, $(this).sortable('serialize'));
      }
    });
  }
});
