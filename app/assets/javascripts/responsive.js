$(document).ready(function() {
	$('.section-half .section-image').each(function(){
		var introImageSource = $(this).find('img').attr('src');
		$(this).css({'background-image' : 'url('+introImageSource+')', });
	});
	$('.nav-trigger').on('click', function (event) {
	    $(this).toggleClass('active');
	    $('.header-content').toggleClass('js-active');
	    event.preventDefault();
	});
});
