$(document).ready(function(){

	$('body').on('click', '#import_btn', function(e) {
	  $('#import_btn').css("pointerEvents","none");
	  $('#import_btn').css("opacity",".5");
		$("#calendar_loading").show();
		$("#calendar").hide();
	});

});	