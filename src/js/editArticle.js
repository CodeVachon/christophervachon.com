$(document).ready(function() {
	$('form[name="articleForm"]').on('change','input,textarea,select',fnUpdatePreview);
	$.getScript("/includes/js/tinymce/jquery.tinymce.min.js", function() {

		$("textarea#body").tinymce({
			script_url: '/includes/js/tinymce/tinymce.min.js',
			width:      '100%',
			height:     200,
			menubar:    false,
			browser_spellcheck : true,
			plugins : "link, code, fullscreen, visualblocks",
			statusbar : true,
			toolbar : "fullscreen | visualblocks code | styles | undo redo | bold italic underline strikethrough | link unlink | blockquote | bullist numlist ",
			setup : function(ed) {
				ed.on('change', function(e) {
					console.log('change event', e);
					fnUpdatePreview();
				});
			}
		}); 

	});
});

function fnUpdatePreview() {
	$('#articlePreview').prepend($('<div>').addClass('alert alert-info static').html('updating'));
	$.post('/admin/previewArticle',$('form[name="articleForm"]').serialize(),function donePost(_data) {
		$('#articlePreview').html(_data);
		if ($('code').size() > 0) {
			$('code').highlightSyntax({definitionsPath: "/includes/js/definitions/"});
		}
	});
}