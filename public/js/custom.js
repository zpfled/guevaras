// Set Welcome Screen Height

$(function () {
	$('.welcome-head').css('height', $(window).innerHeight());
})

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

function deleteFilterCategories(menu) {
	if (menu.options[menu.selectedIndex].text === 'Lunch') {
		$('#lunch-delete').show();
		$('#dinner-delete').hide();
		$('#wine-delete').hide();
		$('#small-plates-delete').hide();
		$('#cocktails-delete').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Dinner') {
		$('#dinner-delete').show();
		$('#lunch-delete').hide();
		$('#wine-delete').hide();
		$('#small-plates-delete').hide();
		$('#cocktails-delete').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Wine') {
		$('#wine-delete').show();
		$('#lunch-delete').hide();
		$('#dinner-delete').hide();
		$('#small-plates-delete').hide();
		$('#cocktails-delete').hide();
	} else if (menu.options[menu.selectedIndex].text === 'Cocktails') {
		$('#cocktails-delete').show();
		$('#small-plates-delete').hide();
		$('#lunch-delete').hide();
		$('#dinner-delete').hide();
		$('#wine-delete').hide();
	} else {
		$('#small-plates-delete').show();
		$('#cocktails-delete').hide();
		$('#lunch-delete').hide();
		$('#dinner-delete').hide();
		$('#wine-delete').hide();
	}
}

// Asynchronous Account Updates --------------------------------------------------------------------------------------

$(function () {
	$('#update-email').on('submit', function(event) {
		
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);

		$.ajax({

			type:		'post',
			url:		'/' + id + '/update/email',
			data:		$(this).serialize(),
			dataType:	'html',

		
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.menu-msg h3').html(data);
				$('#cancel-update-info').click();
				$('#cancel-edit-email').click();
				$('.menu-msg').fadeIn(200).delay(800).fadeOut(1000);

			},
			error: function() {
				$('#cancel-update-info').click();
				$('#cancel-edit-email').click();
				errorMessage();
			}
		});
	});
});

$(function () {
	$('#update-password').on('submit', function(event) {
		
		event.preventDefault();
		var id = $(this).find('.id').text();
		var button = $(this);

		$.ajax({

			type:		'post',
			url:		'/' + id + '/update/password',
			data:		$(this).serialize(),
			dataType:	'html',

		
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.menu-msg h3').html(data);
				$('#cancel-update-info').click();
				$('#cancel-edit-password').click();
				$('.menu-msg').fadeIn(200).delay(800).fadeOut(1000);

			},
			error: function() {
				$('#cancel-update-info').click();
				$('#cancel-edit-password').click();
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
				$('#cancel-manage-users').click();
				$('#cancel-add-user').click();
				$('#menu').html(data);
			},
			error: function() {
				$('#cancel-manage-users').click();
				$('#cancel-add-user').click();
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
				$('#cancel-manage-users').click();
				$('#cancel-delete-user').click();
			},
			error: function() {
				$('#cancel-manage-users').click();
				$('#cancel-delete-user').click();
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
				$('#cancel-manage-menu').click();
				$('#cancel-add').click();
			},
			error: function() {
				$('#cancel-manage-menu').click();
				$('#cancel-add').click();
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
				$('#cancel-manage-menu').click();
				$('#cancel-edit').click();
			},
			error: function() {
				$('#cancel-manage-menu').click();
				$('#cancel-edit').click();
				errorMessage();
			}
		});
	});
});

$(function () {
	$('#delete-item').on('submit', function(event) {
		
		event.preventDefault();

		$.ajax({
			type:		'post',
			url:		'/delete',
			data:		$(this).serialize(),
			dataType:	'html',
			
			success: function(data) {
				$('.modal').slideUp(200);
				$('.modal-backdrop').fadeToggle(200);
				$('.add-msg h3').html('changes saved');
				$('.add-msg').fadeIn(750).fadeOut(750);
				$('#menu').html(data);
				$('#cancel-manage-menu').click();
				$('#cancel-delete').click();
			},
			error: function() {
				$('#cancel-manage-menu').click();
				$('#cancel-delete').click();
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

// Parallax Scrolling Fanciocity --------------------------------------------------------------------------------------

$(function() {
	// Init Skrollr
	if(!(/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent || navigator.vendor || window.opera)){
		var s = skrollr.init({
			render: function(data) {
				// Debugging - Log the current scroll position.
				console.log(data.curTop);
			}
		});
		// Refresh Skrollr after resizing our sections
		s.refresh($('.homeSlide'));
	}
});


