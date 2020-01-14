
$(document).ready(function(){
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


