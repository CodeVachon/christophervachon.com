$(document).ready(function() {
	$('form[name="articleForm"]').on('change','input,select',fnUpdatePreview);
	$('[name="bodyMD"]').on('keyup',function(e) {
		$('[name="body"]').val(fnConvertMarkDownToHTML($(this).val()));
		fnUpdatePreview();
	});

	$('.previewPane').on('click','a',function(e) {
		e.preventDefault();
		alert("Click to " + $(this).prop("href") + " Prevented!");
	});
	$('.previewPane .btn').remove();
});


function fnUpdatePreview() {
	$('.previewPane article header h1, .previewPane article header p.title a').html($('form[name="articleForm"] [name="title"]').val());
	$('.previewPane article header p.date').html("Posted: " + $('form[name="articleForm"] [name="publicationDate"]').val());
	$('.previewPane article.blog-summary section').html($('form[name="articleForm"] [name="summary"]').val());
	$('.previewPane #articlePreview section').html($('form[name="articleForm"] [name="body"]').val());
}


function fnConvertMarkDownToHTML(_markdown) {
	var _html = $('<body>');

	var _lines_raw = _markdown.split(/(?:\r|\n){2,}/gm);
	var _lnC = _lines_raw.length;
	var _lines = [];
	for (var _ri = 0; _ri < _lnC; _ri++) {
		if (_lines_raw[_ri].charAt(0) == "#") {
			var _tmp_lines = _lines_raw[_ri].split(/(?:\r|\n){1,}/gi);
			for (var _rj = 0; _rj < _tmp_lines.length; _rj++) {
				if (_tmp_lines[_rj].length > 0) {
					_lines.push(_tmp_lines[_rj]);
				}
			}
		} else {
			if (_lines_raw[_ri].length > 0) {
				_lines.push(_lines_raw[_ri]);
			}
		}
	}

	_lnC = _lines.length;

	var _formats = {
		'strong': {
			'patterns': [
				"(?:\\_{2})([^_{2}]+)(?:\\_{2})",
				"(?:\\*{2})([^*{2}]+)(?:\\*{2})"
			],
			'map': "<strong>$1</strong>"
		},
		'em': {
			'patterns': [
				"(?:\\_{1})([^_{1}]+)(?:\\_{1})",
				"(?:\\*{1})([^*{1}]+)(?:\\*{1})"
			],
			'map': "<em>$1</em>"
		},
		'strike': {
			'patterns': [
				"(?:-{1})([^-]+)(?:-{1})"
			],
			'map':'<strike>$1</strike>'
		},
		'code-block': {
			'patterns': "(?:`{3})([^(?:\r|\n)]+)?([^`{3}]+)(?:`{3})",
			'map':"<pre><code class='$1'>$2</code></pre>"
		},
		'code': {
			'patterns': "(?:`)([^`]+)(?:`)",
			'map':"<code>$1</code>"
		},
		'img': {
			'patterns': "!\\[([^\\]]+)\\]\\(([^\\)]+)\\)",
			'map':'<img src="$2" alt="$1" title="$1" />'
		},
		'a': {
			'patterns': "\\[([^\\]]+)\\]((?:\\()([^\\s]+)\\s?([^\\)]+?)?(?:\\)))",
			'map': "<a href='$3' title='$4'>$1</a>"
		},
		'a-natural': {
			'patterns': "\\[([^\\]]+)\\]",
			'map': "<a href='$1'>$1</a>"
		}
	};

	for (var i = 0; i < _lnC; i++) {
		var _tag = "p";
		// If Line is a Header
		if (_lines[i].charAt(0) == "#") {
			var _depth = _lines[i].match(/^#{1,6}/)[0].length;
			_tag = "h" + _depth;
			_lines[i] = _lines[i].replace(/^#{1,6}/, "");
		} else if (_lines[i].charAt(0) == "-") {
			_tag = "ul";
			_lines[i] = "<li>" + _lines[i].replace(/(?:\n|\r)(?:(?:\s|\t){1,})?\-/g,"</li><li>") + "</li>";
			_lines[i] = _lines[i].replace(/<li>\-{1,}/gi, "<li>");
		}

		// formatting
		for (var _iTag in _formats) {
			if (Array.isArray(_formats[_iTag].patterns)) {
				for (var j in _formats[_iTag].patterns) {
					_lines[i] = parseInlineTag(_lines[i], _formats[_iTag].map, _formats[_iTag].patterns[j]);
				}
			} else {
				_lines[i] = parseInlineTag(_lines[i], _formats[_iTag].map, _formats[_iTag].patterns);
			}
		}

		_html.append($('<' + _tag + '>').html(_lines[i].replace(/\n|\r/g,"<br />")));
	}
	return _html.html();
}


function parseInlineTag(_string, _map, _pattern) {
	var _regex = new RegExp(_pattern, "gi");
	return _string.replace(_regex, _map);
}