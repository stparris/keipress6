

$(document).on('turbolinks:load', function() {
  $(".icon-tooltip").tooltip({
    trigger :'manual'
  });
  $(".icon-zoom-in").css("cursor","pointer");
  $(".icon-zoom-out").css("cursor","pointer");
  $(".icon-zoom-in").on('click', function () {
    var button = this.id;
    var collection_id = button.split('_')[1];
    $("#collection_"+collection_id).show();
    $("#zoomin_"+collection_id).hide();
    $("#zoomout_"+collection_id).show();
  });

  $(".icon-zoom-out").on('click', function () {
    var button = this.id;
    var collection_id = button.split('_')[1];
    $("#collection_"+collection_id).hide();
    $("#zoomin_"+collection_id).show();
    $("#zoomout_"+collection_id).hide();
  });

  $('.icon-btn').on('click', function () {
    var button = this.id;
    var icon_id = button.split('_')[2];
    var copy_text = document.getElementById("icon_value_"+icon_id);
    copy_text.select();
    document.execCommand("copy");
    $("#icon_btn_"+icon_id).tooltip("hide");
    $("#icon_value_"+icon_id).attr('data-original-title', "Copied: " + copy_text.value);
    $("#icon_value_"+icon_id).tooltip('show');
    setTimeout(function() {
      $("#icon_value_"+icon_id).tooltip("hide");
    }, 2000);
  });



});
