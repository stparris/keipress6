import FileUploadWithPreview from 'file-upload-with-preview'
import 'file-upload-with-preview/dist/file-upload-with-preview.min.css'

$(document).on('turbolinks:load', function() {
  if ($("#upload_image").length) {
    $("#submit_upload").prop("disabled", true);
    var upload = new FileUploadWithPreview('newImageUpload', {
      options: {
        maxFileCount: 1,
        maxFileSize: 4000000
      }
    });
    $("#image_preview_upload_file").change(function (e) {
      $("#submit_upload").prop("disabled", false);
    });
    $("#image_preview_reset").click(function (e) {
      $("#submit_upload").prop("disabled", true);
    });
  }
  if ($("#upload_images").length) {
    $("#submit_upload").prop("disabled", true);
    var upload = new FileUploadWithPreview('multipleImageUploads', {
      options: {
        maxFileCount: 10,
        maxFileSize: 4000000
      }
    });
    $("#image_batch_upload_upload_images").change(function (e) {
      $("#submit_upload").prop("disabled", false);
    });
    $("#image_preview_reset").click(function (e) {
      $("#submit_upload").prop("disabled", true);
    });
  }
});
