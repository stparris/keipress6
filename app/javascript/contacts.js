$(document).ready(function(){

	var isValidEmailAddress;
	isValidEmailAddress = function(emailAddress) {
	  var pattern;
	  pattern = void 0;
	  pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
	  return pattern.test(emailAddress);
	};

	if ($("#contact_form").length) {
		$(document).on("change",'#confirmation_switch',function() {
			$("#email_error").hide();
			$("#contact_email").removeClass('input-error');
			let email = $("#contact_email").val();
			let first_name = $("#first_name").val();
			let last_name = $("#last_name").val();
			if (email.length > 0 && isValidEmailAddress(email)) {
				$("#contact_submit_btn").attr("disabled",false);
			} else {
				$("#email_error").show();
				$("#submit_btn").attr("disabled",true);
				$("#contact_email").addClass('input-error');
				$("#confirmation_switch").prop('checked', '');
	      $('html, body').animate({
	          scrollTop: $('#contact_div').offset().top
	      }, 500);
			}
		});

		$(document).on("click",'#contact_submit_btn',function(event) {
			event.preventDefault();
      post_data = $("#contact_form").serialize();
      $.ajax({
        dataType: 'json',
        url: '/contacts',
        type: 'POST',
        data: post_data,
        success: function(data) {
          if (data.success === 'true') {
          	$("#contact_div").hide();
          	$("#thank_you_div").show();
          } else {
            $("#error_div").html(data.message);
            $("#error_div").show();
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          $("#error_div").html(textStatus + ': ' + errorThrown);
          $("#error_div").show();
        }
      });
      $("#content_div").hide();  
    });
	}
});