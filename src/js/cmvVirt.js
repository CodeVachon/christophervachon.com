$(document).ready(function() {
	$('.navbar').on('click','.navbar-toggle',function(e) {
		console.log("Navbar Toggle Clicked");
		var _collapse = $(this).closest('.navbar').find('.navbar-collapse');
		_collapse.toggleClass('show');
	});

	$('.nav-socialmedia').on('click',".search",function(e) {
		e.preventDefault();
		$(this).toggleClass('active');
		if ($(this).hasClass('active')) {
			console.log("add form");
			var _form = $('<form>').prop({"action":"/blog/search","method":"get"}).addClass("inline-search")
				.append($('<input>').prop({"type":"text","name":"search_for","placeholder":"Search For..."}))
				.append($('<button>').prop({"type":"submit"}).text("Search"));
			_form.hide();
			$(this).closest("li").append(_form);
			_form.slideDown("fast");
		} else {
			console.log("remove form");
			$(this).closest("li").find('form').slideUp("fast", function() { $(this).remove(); });
		}
	});
});
