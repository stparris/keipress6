$(document).on('turbolinks:load', function() {
	var set_container_select, container_type;
	set_container_select = function(container_type) {
		if (container_type === 'navigation') {
			$("#navigation_select").show();
		} else {
			$("#navigation_select").hide();
		}
	}
	$("#container_container_type").change(function (e) {
		container_type = $("#container_container_type option:selected").val();
		set_container_select(container_type);
	});
	if ($("#container_container_type").length) {
		container_type = $("#container_container_type option:selected").val();
		set_container_select(container_type);
	}
});
