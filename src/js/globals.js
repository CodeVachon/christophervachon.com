$(document).ready(function initDom() {
	if ($('code').size() > 0) {
		$('code').highlightSyntax({definitionsPath: "/includes/js/definitions/"});
	}

	$('.admin-btn').on("click",function toggleAdminMenu() {
		$(this).children('.glyphicon').toggleClass('glyphicon-chevron-right').toggleClass('glyphicon-chevron-left');
		$('.admin-menu').toggleClass('open');
		$('body').toggleClass('admin-menu-open');
	});
});
