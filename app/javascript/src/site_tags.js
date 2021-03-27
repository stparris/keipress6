$(document).on('turbolinks:load', function() {
  jQuery(function() {
    var site_tag_url;
    if ($('#site_tags').length) {
      post_url = $('#site_tags').data('sort-items-url');
      return $('#site_tags').sortable({
        axis: 'y',
        handle: '.handle',
        update: function() {
          return $.post(post_url, $(this).sortable('serialize'));
        }
      });
    }

    $(document).on("change",'#site_tag_tag_type',function() {
      let tag_type = $(this).val();
      if (tag_type === 'script') {
        $("#site_tag_value").val('<script type="text/javascript">\n</script>');
      } else if (tag_type === 'style') {
        $("#site_tag_value").val('<style></style>');
      } else if (tag_type === 'link') {
        $("#site_tag_value").val('<link type="" rel="" href="" />');
      } else {
        $("#site_tag_value").val('<meta name="" content="" />');
      }

    });
  });
});
