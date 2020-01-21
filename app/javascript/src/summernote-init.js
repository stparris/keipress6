
require('bootstrap/js/src/modal.js');
require('bootstrap/js/src/dropdown.js');
require('bootstrap/js/src/tooltip.js');
require('bootstrap/dist/css/bootstrap.css');
require('summernote/dist/summernote-bs4.css');
require('summernote');

$('.summernote').summernote();
$(document).on('turbolinks:load', function() {

  $('[data-provider="summernote"]').each(function() {
    return $(this).summernote({
      height: 300,
      toolbar: [
      	['style',['style']],
      	['bold',['bold', 'italic', 'underline','strikethrough', 'clear']],
      	['fontsize', ['fontsize']],
		    ['color', ['color']],
    		['para', ['ul', 'ol', 'paragraph']],
    		['insert',['table','link','hr']],
    		['display',['fullscreen','codeview']]
    	]
    })
  });
});


