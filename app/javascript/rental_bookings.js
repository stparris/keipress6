$(document).on('turbolinks:load', function() {
	if ($("#booking_form").length) {
  	let minStart = $("#minStart").attr('value');
  	let minDays = $("#minDays").attr('value');
  	let defaultDate = Array($("#defaultDate").attr('value'));
    let calendarStatus = $("#calendarStatus").attr('value');
    let calendarId = $("#calendarId").attr('value');
    var datepicker;

  	function check_dates(dates) {
      if (dates[0] && dates[1]) {
    		let symd = dates[0].split(/-/);
  	 		let eymd = dates[1].split(/-/);
  			let firstDate = new Date(symd[0],symd[1],symd[2]);
  			let secondDate = new Date(eymd[0],eymd[1],eymd[2]);
  			let diffDays = Math.round((secondDate - firstDate)/(1000*60*60*24));
  			if (diffDays < minDays) {
  				$("#rental_booking_start_date").val('');
  				$("#rental_booking_end_date").val('');
  				datepicker.setDate();
  				$('#minStayModal').modal();
  				datepicker.setDate();
  				$("#select_guests").hide();
  			} else {
          // May not be necessary.
          // let url = "/calendars/"+calendarId+"?start_date="+dates[0]+"&end_date="+dates[1];
          // $.get(url, function( data ) {
          //   if (data.conflict === true) {
          //     $("#rental_booking_start_date").val('');
          //     $("#rental_booking_end_date").val('');
          //     datepicker.setDate();
          //     let booked = "";
          //     $.each(data.booked, function(index, item) {
          //       booked += "<li>" + item + "</li>";
          //     });
          //     $("#booked_dates").html(booked);
          //     $('#bookedModal').modal();
          //     datepicker.setDate();
          //     $("#select_guests").hide();
          //   } else {
          //     get_details();
          //     $("#select_guests").show();
          //   }
          // });
          get_details();
          $("#select_guests").show();
  			}
      } else {
        datepicker.setDate();
      }
  	}

    function get_details() {
      $("#booking_details").hide();
      let guests = $("#rental_booking_guests").val();
      let rental_id = $("#rental_booking_rental_id").val();
      let start_date = $("#rental_booking_start_date").val();
      let end_date = $("#rental_booking_end_date").val();
      let url = "/rental_bookings/new?rental_booking[rental_id]="+rental_id+"&rental_booking[guests]="+guests+"&rental_booking[start_date]="+start_date+"&rental_booking[end_date]="+end_date;
      $.get(url, function( data ) {
        if (data.success === 'true') {
          $("#booking_nights").html(data.nights);
          if (data.is_regular_rate == true) {
            $("#discount_text").hide();
            $("#regular_text").show();
          } else {
            $("#regular_text").hide();
            $("#discount_text").show();
          }
          $("#booking_base_rate").html(data.base_rate);
          $("#booking_extra_rate").html(data.extra_rate);
          $("#booking_amount").html(data.amount);
          $("#booking_tax").html(data.tax);
          $("#booking_total").html(data.total);
          $("#booking_deposit").html(data.deposit);
          $(".full-amount").each(function() {
            $(this).html(data.total);
          });
          $(".deposit-amount").each(function() {
            $(this).html(data.deposit);
          });
          $("#booking_details").show();
          $("#booking_form").show();
          if ($("#email_form").length && $("#email_display").is(":hidden")) {
            $("#email_form").show();
          }
        } else {
          $("#booking_error").show();
          console.log('succes: '+data.success+' message: '+data.message);
        }
      }, "json" );
    }

    function set_flatpicker() {
      let booked = $('#booked').attr('value').split(",");
  		datepicker = flatpickr("#date_range", {
  			mode: "range",
    		altInput: true,
      	altFormat: "j M Y",
    		minDate: minStart,
    		disable: booked,
    		defaultDate: defaultDate,
  			onClose: function(selectedDates, dateStr, instance) {
          $("#select_guests").hide();
  				let dates = dateStr.split(' to ');
  				$("#rental_booking_start_date").val(dates[0]);
  				$("#rental_booking_end_date").val(dates[1]);
  				check_dates(dates);
      	}
  		});
      $("#checkingCalendar").hide();
      $("#booking_form").show();
    }

    if (calendarStatus === 'stale') {
      $("#checkingCalendar").show();
      $.ajax({
        url: "/calendars/"+calendarId,
        type: 'patch',
        dataType: 'json',
        data: '',
        success: function(data) {
          if (data.success === 'true') {
            $('#booked').attr('value',data.booked);
            set_flatpicker();
          } else {
            $('#errorMessage').html(data.message);
            $('#errorMessage').show();
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          $('#errorMessage').html(textStatus + ': ' + errorThrown);
          $('#errorMessage').show();
        }
      });
    } else {
      set_flatpicker();
    }

		$(document).on("change",'#rental_booking_guests',function() {
      get_details();
    });

    $(document).on("click",'#submit_booking_btn',function(event) {
      event.preventDefault();
      $("#submit_booking_btn icon").removeClass('icon-ok');
      $("#submit_booking_btn icon").addClass('icon-spin3');
      $("#submit_booking_btn icon").addClass('animate-spin');
      $("#submit_booking_btn").attr("disabled",true);
      $("#payment_card_errors").hide();
      $("#submit_booking_btn").parents('form').submit();
    });

    $(document).on("click",'.payment-btn',function() {
      let payment_method_id = this.id.split('_')[2];
      console.log('payment_method_id: '+payment_method_id);
      let payment_method_type = $("#payment_method_type_"+payment_method_id).attr("value");
      if (payment_method_type === 'card_paid' || payment_method_type === 'card_deposit') {
        $("select#payment_card_brand").html('');
        let brands = $("#payment_brands_"+payment_method_id).attr('value').split(',');
        $("#payment_card_brand").append('<option>-------------</option>');
        $.each(brands, function(index, brand) {
          let id_label = brand.split('-');
          $("#payment_card_brand").append('<option value="'+id_label[0]+'">'+id_label[1]+'</option>');
        });
        $("#payment_card").show();
      }
      if ($("#collapse_payment_method_"+payment_method_id).hasClass('show')) {
        console.log('payment_method_id: show');
        $("#collapse_payment_method_"+payment_method_id).removeClass('show');
        $("#collapse_payment_method_"+payment_method_id).collapse();
        $("#submit_booking_btn").attr("disabled",true);
        $("#rental_booking_payment_method_id").val('');
        $('#payment_method_'+payment_method_id+' icon').removeClass('icon-dot-circled');
        $('#payment_method_'+payment_method_id+' icon').addClass('icon-circle-empty');
        if (payment_method_type === 'card_paid' || payment_method_type === 'card_deposit') {
          $("#payment_card").hide();
        }
      } else {
        console.log('payment_method_id: no show');
        $("#rental_booking_payment_method_id").val(payment_method_id);
        $(".paymethod-method-collapse").each(function() {
          $("#"+this.id).removeClass('show');
          $("#"+this.id).collapse();
          $("#payment_method_"+this.id+' icon').removeClass('icon-dot-circled');
          $("#payment_method_"+this.id+' icon').addClass('icon-circle-empty');
        });
        $(".payment-btn").each(function() {
          $("#"+this.id+' icon').removeClass('icon-dot-circled');
          $("#"+this.id+' icon').addClass('icon-circle-empty');
        });
        $("#collapse_payment_method_"+payment_method_id).addClass('show');
        $("#submit_booking_btn").attr("disabled",false);
        $('#payment_method_'+payment_method_id+' icon').removeClass('icon-circle-empty');
        $('#payment_method_'+payment_method_id+' icon').addClass('icon-dot-circled');
        if (payment_method_type === 'card_paid' || payment_method_type === 'card_deposit') {
          $("#payment_card").show();
        } else {
          $("#payment_card").hide();
        }
      }
      $('html, body').animate({
          scrollTop: $('#orphan_search').offset().top
      }, 100);
    });
	}
});
