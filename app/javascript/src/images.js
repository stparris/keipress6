$(document).on('turbolinks:load', function() {

	//$('.image-select').on('click', function (e) {
	$( ".image-select" ).click(function() {
    var button_id = this.id;
		var image_id = button_id.split('_')[2];
		$(".select-image").removeClass('image-selected');
		$("#image_select_"+image_id).addClass('image-selected');
		var select_text = $("#card_title_"+image_id).text();
		$("#image_text").text(select_text);
		$("#hidden_image_field").val(image_id);
  });

  $("#image_batch_naming_prefix").attr('disabled', true);
  $('#image_batch_rename_with_sequence').on('click', function (e) {
    $("#image_batch_naming_prefix").attr('disabled', false);
  });
  $('#image_batch_use_filename').on('click', function (e) {
    $("#image_batch_naming_prefix").attr('disabled', true);
  });

  $("#image_batch_publish").attr('disabled', true);
  $("#image_batch_quality").on('change', function (e) {
    let quality = $("#image_batch_quality").val();
    if (quality === '0') {
      $("#image_batch_publish").attr('disabled', true);
      $("#image_batch_publish").val('false');
    } else {
      $("#image_batch_publish").attr('disabled', false);
    }
  });
});

