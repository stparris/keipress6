$(document).ready(function(){

	$(document).on("change",'.country',function() {
		let country_id = $(this).val();
		$("#address_details").hide();
		let stateSelect = $(".state-select");
		let url = "/countries/"+country_id;
    $.get(url, function( data ) {
    	if (data.success === true) {
    		if (data.states.length > 0) {
    			var select_options = "";
    			for (i = 0; i < data.states.length; i++) {
    				select_options = select_options+'<option value="'+data.states[i].id+'">'+data.states[i].name+'</option>';
					}
					stateSelect.empty().append(select_options);
					$("#country_phone_code").html(data.phone_code);
					$("#address_details").show();
				}
    	} else {
    		console.log(data.message);
    	}
    }, "json" );
	});
});

