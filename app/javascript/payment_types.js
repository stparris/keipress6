$(document).ready(function(){
	function set_gateway(payment_type) {
		if (payment_type === 'card_paid' || payment_type === 'card_deposit') {
			$("#payment_gateway").show();
		} else {
			$("#payment_gateway").hide();
		}
	}
	if ($("#payment_type_payment_type").length) {
		let payment_type = $("#payment_type_payment_type").val();
		$(document).on("change",'#payment_type_payment_type',function() {
			set_gateway($(this).val());
		});
		set_gateway(payment_type);
	}
});



