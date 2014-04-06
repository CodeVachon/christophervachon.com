$(document).ready(function initDom() {
	$('pre code').each(function eachCodeBlock() { $(this).highlightSyntax(); });

	$('.admin-btn').on("click",function toggleAdminMenu() {
		$(this).children('.glyphicon').toggleClass('glyphicon-chevron-right').toggleClass('glyphicon-chevron-left');
		$('.admin-menu').toggleClass('open');
		$('body').toggleClass('admin-menu-open');
	});
});
