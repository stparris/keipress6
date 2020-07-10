$(document).on('turbolinks:load', function() {
  if ($("#gallery_modal").length) {
    function set_galery(width,gallery) {
      let thumbs = "";
      let i = 0;
      $(gallery.slides).each(function(index,slide){
        if (i === 0) {
          thumbs += '\n<div class="carousel-item';
          if (index === 0) {
            thumbs += ' active">\n';
          } else {
            thumbs += '">\n';
          }
          thumbs += '<div class="slide-box">\n';
        }
        thumbs += '   <a class="gallery-thumbnail" id="slide_'+gallery.id+'_'+index+'"><img id="img_'+gallery.id+'_'+index+'" src="'+slide.thumb_url+'"></a>\n';
        if (width >= 992) {
          // 4 per slide
          if (i === 3 || index === gallery.slides.length - 1) {
            thumbs += '</div>\n</div>\n';
          }
          i += 1
          if (i === 4) {
            i = 0;
          }
        } else if (width >= 768 && width < 992) {
          // 3 per slide
          if (i === 2 || index === gallery.slides.length - 1) {
            thumbs += '</div>\n</div>\n';
          }
          i += 1
          if (i === 3) {
            i = 0;
          }
        } else if (width >= 576 && width < 768) {
          // 2 per slide
          if (i === 1 || index === gallery.slides.length - 1) {
            thumbs += '</div>\n</div>\n';
          }
          i += 1
          if (i === 2) {
            i = 0;
          }
        } else {
          thumbs += '</div>\n</div>\n';
        }
      });
      $("#image_gallery_inner_"+gallery.id).html(thumbs);
      $(gallery.slides).each(function(index,slide){
        console.log(slide.name+' '+slide.caption);
        $('#img_'+gallery.id+'_'+index).attr('alt',slide.name);
        $('#img_'+gallery.id+'_'+index).attr('title',slide.caption);
      });
      $("#image_gallery_"+gallery.id).carousel('dispose');
      let base_interval = gallery.interval > 0 ? gallery.interval : false;
      let interval = base_interval ? images_per_slide(width) * base_interval : false;
      $("#image_gallery_"+gallery.id).carousel({
        interval: interval,
        pause: gallery.with_pause,
        ride: gallery.with_ride
      });
    }

    function images_per_slide(width) {
      if (width >= 992) {
        return 4;
      } else if (width >= 768 && width < 992) {
        return 3;
      } else if (width >= 576 && width < 768) {
        return 2;
      } else {
        return 1;
      }
    }

    function check_width() {
      let new_width = $(window).width();
      let img_per_slide = images_per_slide(new_width);
      if (img_per_slide !== images_per_slide(width)) {
        for (let id in galleries) {
          set_galery(new_width,galleries[id]);
        }
      }
      width = new_width;
    }
    let width = $(window).width();
    let current_gallery_id = 0;
    let galleries = {};
    $.each($("gallery"), function() {
      gallery = $.parseJSON($(this).attr('value'));
      galleries[gallery.id] = gallery;
      current_gallery_id = gallery.id;
      set_galery(width,gallery);
    });

    $(window).resize(function() {
      check_width();
    });

    $(document.body).on('click', '.gallery-thumbnail' ,function(){
      let slide_id = this.id;
      current_gallery_id = slide_id.split('_')[1];
      let index = slide_id.split('_')[2];
      let gallery = galleries[current_gallery_id];
      $("#image_gallery_"+current_gallery_id).carousel('pause');
      let slide = gallery.slides[index];
      $("#slide_title").html(slide.name);
      let srcset = $("#imageurls_"+slide.id).attr('srcset');
      $("#slide_image").attr('srcset',srcset);
      let src = $("#imageurls_"+slide.id).attr('src');
      $("#slide_image").attr('src',src);
      $("#slide_image").attr('alt',slide.name);
      $("#slide_image").attr('title',slide.caption);
      if (gallery.with_captions === true) {
        $("#slide_caption").html(slide.caption);
      }
      if (gallery.with_copyrights === true) {
        $("#slide_copyright").html(slide.copyright);
      }
      $("#gallery_modal").modal('show');
    });

    $('#gallery_modal').on('hidden.bs.modal', function (e) {
      $("#image_gallery_"+current_gallery_id).carousel('cycle');
      $("#slide_image").attr('srcset',"");
      $("#slide_image").attr('src',"");
      $("#slide_image").attr('alt',"");
      $("#slide_image").attr('title',"");
      $("#slide_caption").html("");
      $("#slide_copyright").html("");
    });
  }
 });
