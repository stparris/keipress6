$(document).on('turbolinks:load', function() {
  $(".youtube-image").on("click", function() {
    let video_id = this.id.split('_')[2];
    let video_src = $("#youtube_src_"+video_id).attr("value");
    let video_title = $("#youtube_title_"+video_id).attr("value");
    let video_caption = $("#youtube_caption_"+video_id).attr("value");
    let video_copyright = $("#youtube_copyright_"+video_id).attr("value");
    $("#youtube_title").html(video_title);
    $("#youtube_caption").html(video_caption);
    $("#youtube_copyright").html(video_copyright);
    $("#youtube_src").attr('src',video_src + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0" );
    $("#youtube_modal").modal('show');
  });

  // stop playing and reset modal
  $('#youtube_modal').on('hide.bs.modal', function (e) {
    $("#youtube_src").attr('src',"");
    $("#youtube_title").html("");
    $("#youtube_caption").html("");
    $("#youtube_copyright").html('');
  })

});
