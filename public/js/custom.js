function raisePrice(id, button, event) {

	$.ajax({
			type:		'get',
			url:		'/' + id + '/raise',
			accepts:	'application/json',
			dataType:	'json',
			
			success: function(data) {
				$('#success-msg').html('raised ' + data.name + ' price to $' + data.price);
				$(button.parent().parent().find('.item-price')).html(data.price);
			},
			error: function() {
				$('#error-msg').html('your device will self-destruct in 5 seconds');
		}
	});
}

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



// $(function (){
// 	$('#viz_form').on('submit', function(ev){
// 	//this happens if form is submitted
// 	//prevent the default behavior of a form (it should do nothing in our case)
// 		ev.preventDefault();

// 		//send an ajax request to our action
// 			$.ajax({
// 				url: "/follower_viz",

// 				//serialize the form and use it as data for our ajax request
// 				data: $(this).serialize(),
// 				//the type of data we are expecting back from server, could be json too
// 				dataType: "html",

// 				success: function(data) {
// 				//if our ajax request is successful, replace the content of our viz div with the response data
// 				$('#viz').html(data);
// 			}
// 		});
 
//  		//show the link to the repo_viz (don't forget: we are still in the submit event!)
//  		$('#viz_link').append($("#viz_form input:first").val());
//  		$('#viz_p').show();
//  	});
 
//  	$('#viz_link').click(function(ev){
// 		//this happens if we click our new shiny link with the submitted username in it
		
// 		//do you remember?! :)
// 		ev.preventDefault();

// 		$.ajax({
// 			url: "/repo_viz",
// 			data: "user="+$("#viz_form input:first").val(),
// 			dataType: "html",
// 			success: function(data) {
// 				$('#viz').html(data);
// 			}
// 		});
// 	});
//  });