
$(document).on('turbolinks:load', function() {
  if ($("#layout_view").length) {
    var view = 'layout';
    $('.page-containers').on('click', function (e) {
      let new_view = 'containers'
      $("#"+view+"_view").hide();
      $("#"+new_view+"_view").show();
      $('#'+view).removeClass('active');
      $('#'+new_view).addClass('active');
      view = new_view;
    });
    $('.page-link').on('click', function (e) {
      let new_view = e.target.id;
      $("#"+view+"_view").hide();
      $("#"+new_view+"_view").show();
      $('#'+view).removeClass('active');
      $('#'+new_view).addClass('active');
      view = new_view;
    });
  }

 });
