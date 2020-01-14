$(document).ready(function(){
	if ($("#theme_colors").length) {
	  function parseFormData($inputs) {
	    let indexed_array = undefined;
	    let unindexed_array = undefined;
	    unindexed_array = $inputs.serializeArray();
	    indexed_array = {};
	    $.map(unindexed_array, function(n, i) {
	      indexed_array[n['name']] = n['value'];
	    });
	    return indexed_array;
	  }

		var color_name;
		var color_value;
		$('body').on('click', '.edit_theme_color', function(e) {
			var color_id = e.target.id.split('_')[3];
			$("#theme_color_copy_"+color_id).hide();
			$("#theme_color_form_"+color_id).show();
			$("#theme_color_edit_"+color_id).hide();
			$("#theme_color_save_"+color_id).show();
			$("#theme_color_cancel_"+color_id).show();
			color_name = $("#theme_color_name_"+color_id).val();
			color_value = $("#theme_color_value_"+color_id).val();
			$("#theme_color_name_"+color_id).prop("disabled",false);
			$("#theme_color_value_"+color_id).prop("disabled",false);
	  });
		$('body').on('click', '.cancel_theme_color', function(e) {
			var color_id = e.target.id.split('_')[3];
			$("#theme_color_form_"+color_id).hide();
			$("#theme_color_copy_"+color_id).show();
			$("#theme_color_edit_"+color_id).show();
			$("#theme_color_save_"+color_id).hide();
			$("#theme_color_cancel_"+color_id).hide();
			$("#theme_color_name_"+color_id).val(color_name);
			$("#theme_color_value_"+color_id).val(color_value);
			$("#theme_color_name_"+color_id).prop("disabled",true);
			$("#theme_color_value_"+color_id).prop("disabled",true);
	  });
		$('body').on('click', '.save_theme_color', function(e) {
			var color_id = e.target.id.split('_')[3];
			color_name = $("#theme_color_name_"+color_id).val();
			color_value = $("#theme_color_value_"+color_id).val();			
			var auth_token = $("#auth_token_"+color_id).val();
      patch_data = '&theme_color[name]='+color_name+'&theme_color[value]='+color_value;
      $.ajax({
        url: '/admin/theme_colors/' + color_id + '?authenticity_token='+auth_token,
        type: 'patch',
        dataType: 'json',
        data: patch_data,
        success: function(data) {
          if (data.success === 'true') {
						$("#theme_color_edit_"+color_id).show();
						$("#theme_color_save_"+color_id).hide();
						$("#theme_color_cancel_"+color_id).hide();
						$("#theme_color_name_"+color_id).val(data.color_name);
						$("#theme_color_value_"+color_id).val(data.color_value);
						$("#theme_color_name_"+color_id).prop("disabled",true);
						$("#theme_color_value_"+color_id).prop("disabled",true);
						$("#theme_color_color_"+color_id).css("background-color", "#"+data.color_value);
						$("#theme_color_text_"+color_id).val("$"+color_name+": #"+color_value+";");
						$("#theme_color_form_"+color_id).hide();

						$("#theme_color_copy_"+color_id).show();
          } else {
          	alert("Oops! Something went wrong");
          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          $('.errorMessage').html(textStatus + ': ' + errorThrown);
          $('.errorMessage').show();
        }
      });
    });
	}

  $(".color-tooltip").tooltip({
    trigger :'manual'
  });
  $('body').on('click', '.color-theme', function(e) {
    var color_id = this.id.split('_')[2];
    var copy_text = document.getElementById("theme_color_text_"+color_id);
    copy_text.select();
    document.execCommand("copy");
    $("#theme_color_"+color_id).tooltip("hide");
    $("#theme_color_text_"+color_id).attr('data-original-title', "Copied: " + copy_text.value);
    $("#theme_color_text_"+color_id).tooltip("show");
    setTimeout(function() {
      $("#theme_color_text_"+color_id).tooltip("hide");
    }, 2000);
  });
 

});



