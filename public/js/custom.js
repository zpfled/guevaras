// Asynchronous Menu Updates

$(function () {
	$('#add-item').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/menu',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('#add-msg').html('success');
				$('#menu').html(data);
			},
			error: function() {
				$('#add-msg').html('sorry, that didn\'t work');
			}
		});
	});
});

function raisePrice(id, button) {

	$.ajax({
			type:		'get',
			url:		'/' + id + '/raise',
			accepts:	'application/json',
			dataType:	'json',
			
			success: function(data) {
				$(button.parent().find('.menu-msg')).html('raised ' + data.name + ' price to $' + data.price);
				$(button.parent().parent().find('.item-price')).html(data.price);
			},
			error: function() {
				$('#error-msg').html('your device will self-destruct in 5 seconds');
		}
	});
}

function reducePrice(id, button) {

	$.ajax({
			type:		'get',
			url:		'/' + id + '/reduce',
			accepts:	'application/json',
			dataType:	'json',
			
			success: function(data) {
				$(button.parent().find('.menu-msg')).html('reduced ' + data.name + ' price to $' + data.price);
				$(button.parent().parent().find('.item-price')).html(data.price);
			},
			error: function() {
				$('#error-msg').html('your device will self-destruct in 5 seconds');
		}
	});
}

function deleteItem(id, button) {

	$.ajax({
			type:		'get',
			url:		'/' + id + '/delete',
			accepts:	'application/json',
			dataType:	'json',
			
			success: function(data) {
				$(button.parent().find('.menu-msg')).html('successfully deleted ' + data.name);
				$(button.parent().parent()).remove();
			},
			error: function() {
				$('#error-msg').html('your device will self-destruct in 5 seconds');
		}
	});
}


// Parallax Scrolling Fanciness

( function( $ ) {
	
	// Setup variables
	$window = $(window);
	$slide = $('.homeSlide');
	$body = $('body');
	
    //FadeIn all sections   
	$body.imagesLoaded( function() {
		setTimeout(function() {
		      
		      // Resize sections
		      adjustWindow();
		      
		      // Fade in sections
			  $body.removeClass('loading').addClass('loaded');
			  
		}, 800);
	});
	
	function adjustWindow(){
		
		// Init Skrollr
		var s = skrollr.init();
		
		// Get window size
	    winH = $window.height();
	    
	    // Keep minimum height 550
	    if(winH <= 550) {
			winH = 550;
		} 
	    
	    // Resize our slides
	    $slide.height(winH);
	    
	    // Refresh Skrollr after resizing our sections
	    s.refresh($('.homeSlide'));
	    
	    
	}
		
} )( jQuery );
