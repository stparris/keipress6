$(document).on('turbolinks:load', function() {
	if ($("#payment_card_brand").length) {
		$(document).on("click","#payment_card_errors_link",function() {
			$("#payment_card_errors").show();
		});
		$(document).on("change","#payment_card_brand",function() {
			if($("#payment_card_brand").val() === '-------------') {
				$("#payment_card_brand_error").show();
				$("#payment_card_brand").addClass('input-error');
			} else {
				$("#payment_card_brand_error").hide();
				$("#payment_card_brand").removeClass('input-error');
			}
		});
    $(document).on("keydown","#payment_card_first_name",function() {
    	$("#payment_card_first_name_error").hide();
    	$("#payment_card_first_name").removeClass('input-error');
	    if ($("#payment_card_brand").val() === '-------------') {
      	$("#payment_card_brand").addClass('input-error');
        $("#payment_card_brand_error").show();
      } else {
      	$("#payment_card_brand").removeClass('input-error');
      	$("#payment_card_brand_error").hide();
      }
    });
    $(document).on("keydown","#payment_card_last_name",function() {
    	$("#payment_card_last_name_error").hide();
    	$("#payment_card_last_name").removeClass('input-error');
      if ($("#payment_card_first_name").val().length < 2) {
      	$("#payment_card_first_name").addClass('input-error');
        $("#payment_card_first_name_error").show();
      } else {
      	$("#payment_card_first_name").removeClass('input-error');
      	$("#payment_card_first_name_error").hide();
      }
    });
    $(document).on("keydown","#payment_card_card_number",function() {
    	$("#payment_card_card_number_error").hide();
    	$("#payment_card_card_number").removeClass('input-error');
      if ($("#payment_card_last_name").val().length < 2) {
				$("#payment_card_last_name").addClass('input-error');
        $("#payment_card_last_name_error").show();
      } else {
      	$("#payment_card_last_name").removeClass('input-error');
      	$("#payment_card_last_name_error").hide();
      }
    });

		$(document).on("change","#payment_card_expiration_month",function() {
			$("#payment_card_expiration_month_error").hide();
			$("#payment_card_expiration_month").removeClass('input-error');
		});

		$(document).on("change","#payment_card_expiration_month",function() {
			$("#payment_card_expiration_year_error").hide();
			$("#payment_card_expiration_year").removeClass('input-error');
		});

    $(document).on("keydown","#payment_card_card_verification",function() {
    	$("#payment_card_card_verification_error").hide();
    	$("#payment_card_card_verification").removeClass('input-error');
      if ($("#payment_card_card_number").val().length === 0) {
				$("#payment_card_card_number").addClass('input-error');
        $("#payment_card_card_number_error").show();
      } else {
      	$("#payment_card_card_number").removeClass('input-error');
      	$("#payment_card_card_number_error").hide();
      }
    });
	}
});
