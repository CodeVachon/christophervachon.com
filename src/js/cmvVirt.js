$(document).ready(function() {
	$('.navbar').on('click','.navbar-toggle',function(e) {
		console.log("Navbar Toggle Clicked");
		var _collapse = $(this).closest('.navbar').find('.navbar-collapse');
		_collapse.toggleClass('show');
	});
});