require('blueimp-file-upload');

$(document).on('turbolinks:load', function() {
  let document_id = '';
  let content_type = '';
  let extention = '';
  let tmp_file = '';

  if($('#image_upload').length) {
    $('#image_upload').fileupload({
      maxChunkSize: 256000,
      maxFileSize: 2000000,
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
      dataType: 'json',
      add(e, data) {
        data.url = '/admin/image_uploads';
        const file = data.files[0];
        // if (file.type === content_type) {
        //   $('#selectedFile').html('Selected file: ' + file.name);
        //   $('.progressBar').show();
        //   return data.submit();
        // } else {
        //   return alert('Invalid file type: \'' + file.name + '\' is not a ' + extention + ' file');
        // }
      },
      progress(e, data) {
        let progress = undefined;
        progress = parseInt((data.loaded / data.total) * 100, 10);
        if (progress <= 100) {
          $('#progress').css('width', progress + '%');
          $('#progressComplete').html(progress + '% complete');
        }
      },
      fail(e, data) {
        $('#noFileWarning').show;
        $('#imageError').html('Upload failed: ' + data.textStatus + ' ' + data.errorThrown);
        $('#imageError').show();
      },
      done(e, data) {
        let ext = undefined;
        let file = undefined;
        file = data.files[0];
        ext = file.name.split('.').pop().toLowerCase();
        $.ajax({
          dataType: 'json',
          url: '/admin/image_uploads/' + image_id + '?tmp_file=' + tmp_file + '&source_filename=' + file.name,
          type: 'PUT',
          success(data) {
            if (data.success === 'true') {
              $('#imageName').html(data.image_link);
              $('#noFileWarning').html('<icon class="icon-attention"></icon> Warning: A file has been uploaded for this record. File from link or File upload will replace it.');
              $('#sourceFilename').html(file.name);
            } else {
              $('#imageError').html(data.message);
              $('#imageError').show();
            }
          },
          error(jqXHR, textStatus, errorThrown) {
            $('#imageError').html('Upload failed: ' + data.textStatus + ' ' + data.errorThrown);
            $('#imageError').show();
          }
        });
      }
    });
  }
});
