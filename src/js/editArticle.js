var _toggleLibraries = true;

$(document).ready(function() {
	$('[name="body"]').on('change',function() {
		fnUpdatePreview();
	});
	$('.previewPane').on('click','a',function(e) {
		e.preventDefault();
		alert("Click to " + $(this).prop("href") + " Prevented!");
	});

	if (_toggleLibraries) { $('.toggleLibraries').addClass('active'); }
	$('.toggleLibraries').on('click', function(e) {
		e.preventDefault();
		if (_toggleLibraries) {
			_toggleLibraries = false;
			$(this).removeClass('active');
		} else {
			_toggleLibraries = true;
			$(this).addClass('active');
		}
		fnUpdatePreview();
	});

	$('.previewPane .btn').remove();
	$('#markdown').on("scroll", function(e) {
		var _scrollValue = $(this).scrollTop();
		var _scrollMaxValue = fnGetMaxScrollTopValue($(this));
		var _scrollPercent = parseInt((_scrollValue / _scrollMaxValue)*100);
		var _previewPane = $('.previewPane');
		var _previewHeight = fnGetMaxScrollTopValue(_previewPane);
		_previewPane.scrollTop(_previewHeight*(_scrollPercent/100));
	});
});

new Vue({
	el: '#editorForm',
	filters: {
		marked: marked
	},
	methods: {
		onKeyUp: function (e) {
			fnUpdatePreview();
		}
	}
});


function fnUpdatePreview() {
	$('.previewPane article header h1, .previewPane article header p.title a').html($('form[name="articleForm"] [name="title"]').val());
	$('.previewPane article header p.date').html("Posted: " + $('form[name="articleForm"] [name="publicationDate"]').val());
	$('.previewPane article.blog-summary section').html($('form[name="articleForm"] [name="summary"]').val());
	$('.previewPane #articlePreview section').html($('form[name="articleForm"] [name="body"]').val());
	if (_toggleLibraries) {
		if ($('.previewPane #articlePreview section').find('pre > code').size() > 0) { $('code').highlightSyntax({definitionsPath: "/includes/js/definitions/"}); }
	}
}

function fnGetMaxScrollTopValue(_elem) {
	var trueDivHeight = _elem[0].scrollHeight;
	var divHeight = _elem.height();
	return trueDivHeight - divHeight;
}