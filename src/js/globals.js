$(document).ready(function initDom() {
	if ($('code').size() > 0) {
		$('code').highlightSyntax({definitionsPath: "/includes/js/definitions/"});
	}

	$('.admin-btn').on("click",function toggleAdminMenu() {
		$(this).children('.fa').toggleClass('fa-caret-left').toggleClass('fa-caret-right');
		$('.admin-menu').toggleClass('open');
		$('body').toggleClass('admin-menu-open');
	});

	$(window).on("scroll", function(e) {
		if ($(this).scrollTop() > 60) {
			$('.navbar').addClass('scrolldown');
		} else {
			$('.navbar').removeClass('scrolldown');
		}
		console.log();
	});
});
