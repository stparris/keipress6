$(document).ready(function(){

	var isValidEmailAddress;
	isValidEmailAddress = function(emailAddress) {
	  var pattern;
	  pattern = void 0;
	  pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
	  return pattern.test(emailAddress);
	};

	if ($("#confirm_email_btn").length) {
		$(document).on("click",'#edit_email_btn',function() {
			$("#email_form").show();
			$("#email_display").hide();
		});
		$(document).on("click",'#confirm_email_btn',function() {
			$("#email_invalid").hide;
			$("#user_details").hide();
			let email = $("#email").val();
			let confirm_email = $("#email_confirmation").val();
			if (email.length > 0 && email === confirm_email) {
				if (email.length > 0 && isValidEmailAddress(email)) {
					$("#email").removeClass('input-error');
					$("#email_confirmation").removeClass('input-error');
					$("#email_invalid").hide();
					console.log(email+' is valid');
					let url = "/users/new?user[email]="+email;
    			$.get(url, function( data ) {
    				if (data.success === true && data.user_persisted === true ) {
    					$("#user_email").val(email);
							if ($("#user_prefix").length) {
								$("#user_prefix").val(data.prefix);
							}
							if ($("#user_first_name").length) {
								$("#user_first_name").val(data.first_name);
							} 
							if ($("#user_middle_name").length) {
								$("#user_middle_name").val(data.middle_name); 
							}
							if ($("#user_last_name").length) {
								$("#user_last_name").val(data.last_name);
							}
							if ($("#user_suffix").length) {
								$("#user_suffix").val(data.suffix);
							}
							if ($("#user_title").length) {
								$("#user_title").val(data.title);
							}
							if ($("#user_marketing").length) {
								$("#user_marketing").val(data.marketing);
							}
							for (i = 0; i < data.addresses.length; i++) {
								let address = data.addresses[i];
								let prefix = address.name === 'primary' ? 'user_address' : address.name
								if ($("#"+prefix+"_address1").length) {
									$("#"+prefix+"_address1").val(address.address1);
								}
								if ($("#"+prefix+"_address2").length) {
									$("#"+prefix+"_address2").val(address.address2);
								}
								if ($("#"+prefix+"_city").length) {
									$("#"+prefix+"_city").val(address.city);
								}
								if ($("#"+prefix+"_post_code").length) {
									$("#"+prefix+"_post_code").val(address.post_code);
								}
								if ($("#"+prefix+"_phone").length) {
									$("#"+prefix+"_phone").val(address.phone);
								}
								if ($("#"+prefix+"_alternative_phone").length) {
									$("#"+prefix+"_alternative_phone")
								}
								if ($("#"+prefix+"_state_id").length) {
									$("#"+prefix+"_state_id").val(address.state_id);
								}
								if ($("#"+prefix+"_country_id").length) {
									$("#"+prefix+"_country_id").val(address.country_id);
								}
							}
							$("#user_names").show();
							$("#email_value").val(email);
							$("#email_form").hide();
							$("#email_display").show();
							if ($("#user_names").length) {
								$("#user_names").show();
							}
							if ($("#primary_address").length) {
								$("#primary_address").show();
							}
							if ($("#payment_methods").length) {
								$("#payment_methods").show();
							}
    				} else if (data.success === true) {
    					$("#user_email").val(email);
							$("#user_names").show();
							$("#email_value").val(email);
							$("#email_form").hide();
							$("#email_display").show();
							if ($("#user_names").length) {
								$("#user_names").show();
							}
							if ($("#primary_address").length) {
								$("#primary_address").show();
							}
							if ($("#payment_methods").length) {
								$("#payment_methods").show();
							}
    				} else {
    					$("#user_email").val('');
    					console.log(data.message);
    				}
    			}, "json" );	
				} else {
					console.log(email+' is invalid');
					$("#email").addClass('input-error');
					$("#email_confirmation").addClass('input-error');
					$("#email_invalid").show();
				}   
			} else {
				console.log(email+' is invalid');
				$("#email").addClass('input-error');
				$("#email_confirmation").addClass('input-error');
				$("#email_invalid").show();			
			}
	  });
	}

});
