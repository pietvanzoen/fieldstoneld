function initSlider(slickOptions) {
	$('.js-gallery').slick($.extend({
		cssEase: 'ease-in-out',
		lazyLoad: 'ondemand',
		pauseOnHover: false
	}, slickOptions || {}));
}

function initPortfolioGallery() {

	var $projectContent = $('.js-project');
	var $gallery = $('.js-gallery');
	var $galleryContainer = $('.js-gallery-container');

	$('.gallery-exit').show();

	function exitGallery() {
		window.location.hash = '';
	}

	function checkHash(fadeTime) {
		fadeTime = typeof fadeTime === 'number' ? fadeTime : 200;
		var hash = window.location.hash;
		if (hash === '#gallery') {
			$galleryContainer.fadeIn(fadeTime, function () {
				$projectContent.hide();
				$gallery.slick('setPosition');
			});
		} else {
			$projectContent.show();
			$galleryContainer.fadeOut(fadeTime);
		}
	}

	checkHash(0);
	$(window).on('hashchange', checkHash);

	$(document).keyup(function(e) {
		switch(e.keyCode) {
			case 37: // left
				$gallery.slick('slickPrev');
				break;
			case 39: // right
				$gallery.slick('slickNext');
				break;
			case 27: // esc
				exitGallery();
				break;
			default: return;
		}
	});

}
