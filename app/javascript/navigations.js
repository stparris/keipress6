$(document).ready(function(){
	var set_navigation_select, navigation_type;
	set_navigation_select = function(navigation_type) {
		if (navigation_type === 'list_group') {
			$("#list_group_help").show();
			$("#navs_help").hide();
			$("#navbar_help").hide();
			$("#navbar_brand").hide();
			$("#navbar_form").hide();
			$("#inputGroup-sizing-default").html("list-group");
			$("#css_classes").show();
		} else if (navigation_type === 'nav') {	
			$("#list_group_help").hide();
			$("#navs_help").show();
			$("#navbar_help").hide();
			$("#navbar_brand").hide();
			$("#navbar_form").hide();
			$("#inputGroup-sizing-default").html("nav");
			$("#css_classes").show();		
		} else if (navigation_type === 'navbar') {	
			$("#list_group_help").hide();
			$("#navs_help").hide();
			$("#navbar_help").show();
			$("#navbar_brand").show();
			$("#navbar_form").show();
			$("#inputGroup-sizing-default").html("navbar");
		  $(".codemirror-navbar").each(function() {
		    CodeMirror.fromTextArea($(this).get(0), {
		      lineNumbers: true,
		      mode: "htmlmixed",
		      tabSize: 2
		    });
		  });	
			$("#css_classes").show();
		} else {
			$("#list_group_help").hide();
			$("#navs_help").hide();
			$("#navbar_help").hide();
			$("#navbar_brand").hide();
			$("#navbar_form").hide();	
			$("#css_classes").hide();
		}
	}

	$("#navigation_navigation_type").change(function (e) {
		navigation_type = $("#navigation_navigation_type option:selected").val();
		set_navigation_select(navigation_type);
	});
	if ($("#navigation_navigation_type").length) {
		navigation_type = $("#navigation_navigation_type option:selected").val();
		set_navigation_select(navigation_type);
	}
});


