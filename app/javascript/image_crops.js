$(document).ready(function(){
  if ($("#image_crop").length) {
    var image_id = $('#image_id').attr('value')
    var $image = $('#image');
    var options = {
        aspectRatio: NaN,
        movable: false,
        preview: '.img-preview',
        toggleDragModeOnDblclick: false
    };

    $image.cropper(options); 
    $("#aspect_ratio").val(NaN);

    $("#aspect_ratio").change(function(e) {
      options.aspectRatio = Number($("#aspect_ratio option:selected").val());
      // $image.cropper('destroy').cropper(options);
      $image.cropper('destroy').cropper(options);
    });  

    $("#rotate_left").click(function(e) {
      $image.cropper('rotate', -0.5);
    });

    $("#rotate_right").click(function(e) {
      $image.cropper('rotate', 0.5);
    });

    $("#rotate_45_left").click(function(e) {
      $image.cropper('rotate', -45);
    });

    $("#rotate_45_right").click(function(e) {
      $image.cropper('rotate',45);
    });

    $("#reset").click(function(e) {
      options.aspectRatio = NaN;
      $("#aspect_ratio").val(NaN);
      $image.cropper('destroy').cropper(options);
    });

    var v_scale = 1;
    var h_scale = 1;
    $("#flip_horizontal").click(function(e) {
      if (h_scale == 1) {
        h_scale = -1;
      } else {
        h_scale = 1;
      }
      $image.cropper('scale', h_scale,v_scale);
    });

    $("#flip_vertical").click(function(e) {
      if (v_scale == 1) {
        v_scale = -1
      } else {
        v_scale = 1
      }
      $image.cropper('scale', h_scale,v_scale);
    });

    var zoom_ratio = 0;
    var zoom_in = 0;
    var zoom_out = 0;
    $("#zoom_in").click(function(e) {
      $image.cropper('zoom', 0.1);
    });

    $("#zoom_out").click(function(e) {
      $image.cropper('zoom', Number(-0.1));
    });

    $('button#save').on('click', function (event) {
      $("#loadingModalTitle").html("Cropping image...");
      //$("#loadingModal").modal('show');
      event.preventDefault();
      $("#image").cropper('getCroppedCanvas').toBlob(function (blob) {
        var formData = new FormData();
        formData.append('image[blob]', blob);
        $.ajax('/admin/image_crops/'+image_id, {
          method: "PUT",
          data: formData,
          processData: false,
          contentType: false,
          success() {
            $("#loadingModal").modal('hide');
            $('#getCroppedCanvasModal').modal('show');
          },
          error() {
            $("#loadingModal").modal('hide');
            alert('Upload error');
          },
        });
      }, 'image/jpeg',0.8);
    });

    $('#getCroppedCanvasModal').on('hidden.bs.modal', function () {
      $("#loadingModalTitle").html("Reloading image...");
      $("#loadingModal").modal('show');
      location.reload();
    });
  }
});