$(document).on('turbolinks:load', function() {
  $(document).on("change",'#watermark_watermark_type',function() {
    let wm_type = $(this).val();
    if (wm_type === 'composite') {
      $("#form_composite").show();
      $("#form_text").hide();
      $("#form_other").show();
    } else if (wm_type === 'text') {
      $("#form_composite").hide();
      $("#form_text").show();
      $("#form_other").show();
    } else if (wm_type === 'replicate') {
      $("#form_composite").hide();
      $("#form_text").show();
      $("#form_other").show();
    } else {
      $("#form_composite").hide();
      $("#form_text").hide();
      $("#form_other").hide();
    }
  });
});
