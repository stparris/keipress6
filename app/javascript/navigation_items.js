$(document).ready(function(){
	jQuery(function() {
	  var post_url;
	  if ($('#navigation_items')) {
	    post_url = $('#navigation_items').data('sort-items-url');
	    return $('#navigation_items').sortable({
	      axis: 'y',
	      handle: '.handle',
	      update: function() {
	        return $.post(post_url, $(this).sortable('serialize'));
	      }
	    });
	  }
	});

});


