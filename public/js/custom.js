
// Email Obfuscation ------------------------------------------------------------------------------------------------

(function($) {
    jQuery.fn.mailto = function() {
        return this.each(function() {
            var email_add = $(this).attr("href").replace(/\s*\(.+\)\s*/, "@");
            var email_text = $(this).html();
            var email_class = $(this).attr("class");
            $(this).before('<a class="' + email_class + '" href="mailto:' + email_add + '" rel="nofollow" title="Email ' + email_add + '">' + email_text + '</a>').remove();
        });
    };

})(jQuery);

$(document).ready(function() {
    $(function() {
        $('.email').mailto();
    });
});

// Error Message -------------------------------------------------------------------------------------------------------

function errorMessage() {
	$('.error-msg h3').html('sorry, that didn\'t work');
	$('.error-msg').fadeIn(750).fadeOut(750);
}

// Filter Menu and Category Inputs --------------------------------------------------------------------------------------

function filterCategories(menu) {
	if (menu.options[menu.selectedIndex].text === 'Lunch') {
		$('#lunch-cats').show();
		$('#dinner-cats').hide();
		$('#wine-cats').hide();
		$('#small-plates-cat').hide();
		$('#cocktails-cat').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Dinner') {
		$('#dinner-cats').show();
		$('#lunch-cats').hide();
		$('#wine-cats').hide();
		$('#small-plates-cat').hide();
		$('#cocktails-cat').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Wine') {
		$('#wine-cats').show();
		$('#lunch-cats').hide();
		$('#dinner-cats').hide();
		$('#small-plates-cat').hide();
		$('#cocktails-cat').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Cocktails') {
		$('#cocktails-cat').show();
		$('#small-plates-cat').hide();
		$('#lunch-cats').hide();
		$('#dinner-cats').hide();
		$('#wine-cats').hide();
	} else {
		$('#small-plates-cat').show();
		$('#cocktails-cat').hide();
		$('#lunch-cats').hide();
		$('#dinner-cats').hide();
		$('#wine-cats').hide();
	}
}

function editFilterCategories(menu) {
	if (menu.options[menu.selectedIndex].text === 'Lunch') {
		$('#lunch-edit').show();
		$('#dinner-edit').hide();
		$('#wine-edit').hide();
		$('#small-plates-edit').hide();
		$('#cocktails-edit').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Dinner') {
		$('#dinner-edit').show();
		$('#lunch-edit').hide();
		$('#wine-edit').hide();
		$('#small-plates-edit').hide();
		$('#cocktails-edit').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Wine') {
		$('#wine-edit').show();
		$('#lunch-edit').hide();
		$('#dinner-edit').hide();
		$('#small-plates-edit').hide();
		$('#cocktails-edit').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Cocktails') {
		$('#cocktails-edit').show();
		$('#small-plates-edit').hide();
		$('#lunch-edit').hide();
		$('#dinner-edit').hide();
		$('#wine-edit').hide();
	} else {
		$('#small-plates-edit').show();
		$('#cocktails-edit').hide();
		$('#lunch-edit').hide();
		$('#dinner-edit').hide();
		$('#wine-edit').hide();
	}
}

// Asynchronous Account Updates --------------------------------------------------------------------------------------

$(function () {
	$('#update-info').on('submit', function(event) {
		
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);

		$.ajax({

			type:		'post',
			url:		'/' + id + '/update',
			data:		$(this).serialize(),
			dataType:	'html',

		
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.menu-msg h3').html(data);
				$(button.parent().parent().find('.item-price')).html(data);
				$('.menu-msg').fadeIn(200).delay(800).fadeOut(1000);
				$('#cancel-edit').click();

			},
			error: function() {
				$('#cancel-edit').click();
				errorMessage();
			}
		});
	});
});

// Asynchronous User Updates --------------------------------------------------------------------------------------

$(function () {
	$('#new-user').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/signup',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.add-msg h3').html('success');
				$('.add-msg').fadeIn(750).fadeOut(750);
				$('#menu').html(data);
				$('#cancel-add').click();
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

$(function () {
	$('#delete-user').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/user/delete',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.add-msg h3').html('success');
				$('.add-msg').fadeIn(750).fadeOut(750);
				$('#menu').html(data);
				$('#cancel-delete').click();
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

// Asynchronous Menu Updates --------------------------------------------------------------------------------------

$(function () {
	$('#add-item').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/menu',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.add-msg h3').html('success');
				$('.add-msg').fadeIn(750).fadeOut(750);
				$('#menu').html(data);
				$('#cancel-add').click();
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

$(function () {
	$('#edit-item').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/edit',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.add-msg h3').html('changes saved');
				$('.add-msg').fadeIn(750).fadeOut(750);
				$('#menu').html(data);
				$('#cancel-edit').click();
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

$(function () {
	$('.raise').on('submit', function(event) {
		
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);

		$.ajax({

			type:		'get',
			url:		'/' + id + '/raise',
			data:		$(this).serialize(),
			dataType:	'html',

		
			success: function(data) {
				$('.menu-msg h3').html('raised price to $' + data);
				$(button.parent().parent().find('.item-price')).html(data);
				$('.menu-msg').fadeIn(200).delay(800).fadeOut(1000);
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

$(function () {
	$('.reduce').on('submit', function(event) {
		
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);

		$.ajax({

			type:		'get',
			url:		'/' + id + '/reduce',
			data:		$(this).serialize(),
			dataType:	'html',

		
			success: function(data) {
				$('.menu-msg h3').html('reduced price to $' + data);
				$(button.parent().parent().find('.item-price')).html(data);
				$('.menu-msg').fadeIn(200).delay(800).fadeOut(1000);
			},
			error: function() {
				errorMessage();
			}
		});
	});
});

$(function () {
	$('.delete').on('submit', function(event) {
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);
		
		$('.delete-confirmation').fadeToggle(200);
		
		$('#no').click(function() {
			$('.delete-confirmation').fadeOut(200);
			return false;
		});

		$('#yes').click(function() {
			$.ajax({

				type:		'get',
				url:		'/' + id + '/delete',
				data:		$(this).serialize(),
				dataType:	'html',
				success: function(data) {
					$(button.parent().parent().parent()).remove();
					$('.delete-msg h3').html('successfully deleted ' + data);
					$('.delete-confirmation').fadeOut(200);
					$('.delete-msg').fadeIn(500).fadeOut(2000);
				},
				error: function() {
					errorMessage();
				}
			});
		});
	});
});

// Parallax Scrolling Fanciocity --------------------------------------------------------------------------------------

$(function() {
	// Init Skrollr
	if(!(/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent || navigator.vendor || window.opera)){
		var s = skrollr.init;
		// var s = skrollr.init({
		// 	render: function(data) {
		// 		// Debugging - Log the current scroll position.
		// 		console.log(data.curTop);
		// 	}
		// });
		// Refresh Skrollr after resizing our sections
		// s.refresh($('.homeSlide'));
	}
});