import FileUploadWithPreview from 'file-upload-with-preview'
import 'file-upload-with-preview/dist/file-upload-with-preview.min.css'

$(document).on('turbolinks:load', function() {
  if ($("#upload_image").length) {
      var upload = new FileUploadWithPreview('newImageUpload', {
        options: {
          maxFileCount: 1,
          maxFileSize: 2000000
        }
      });
  }
});
