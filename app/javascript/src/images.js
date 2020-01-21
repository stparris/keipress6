$(document).on('turbolinks:load', function() {

	$('.image-select').on('click', function (e) {
		var button_id = e.target.id;
		var image_id = button_id.split('_')[2];
		$(".select-image").removeClass('image-selected');
		$("#image_select_"+image_id).addClass('image-selected');
		var select_text = $("#card_title_"+image_id).text();
		$("#image_text").text(select_text);
		$("#hidden_image_field").val(image_id);
  });
});

