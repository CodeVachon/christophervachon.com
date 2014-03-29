$(document).ready(function initDom() {
	$('pre code').each(function eachCodeBlock() {
		var _settings = {
			tab: "&nbsp;&nbsp;&nbsp;&nbsp;"
		};
		var _table = $('<table>').addClass('syntax-highlighting').append(
		$('<tr>')
			.append($('<td>').addClass('gutter'))
			.append($('<td>').addClass('code')));

		var _patterns = [{
			class: "string",
			pattern: "((?:\"|')[^\"']{0,}(?:\"|'))"
		}, {
			class: 'const',
			pattern: "(?:(var|new|function|private|if|else|for|in)\\s)"
		}, {
			class: 'operator',
			pattern: "((?:[\\+\\-\\=\\!\\|\\:\\[\\]\\(\\)\\{\\}\\>\\<]|&amp;|&lt;|&gt;){1,}|(?:[^\\*\\/]\\/(?!\\/|\\*)))"
		}, {
			class: 'comment',
			pattern: "\\/\\/[^\\(\\n|\\r)]+|\\/\\*|\\*\\/"
		}];
		var _computedRegExString = "";
		for (var k in _patterns) { _computedRegExString += _patterns[k].pattern + "|"; }
		_computedRegExString = "(" + _computedRegExString.replace(/\|$/, "") + ")";
		var _computedRegEx = new RegExp(_computedRegExString, "gi");


		var _code = $(this).html().split(/\r\n|\r|\n|<br(?:\s\/)?>/g);
		var _numLines = (_code.length - 1);
		for (var i = 0; i <= _numLines; i++) {
			var _hightlightedCode = _code[i].replace(/\t/g,_settings.tab);
			_hightlightedCode = _hightlightedCode.replace(_computedRegEx, "<span class='found'>$1</span>");
			_hightlightedCode = $('<div>').html(_hightlightedCode || "&nbsp;");
			_table.find('td.gutter').append($('<div>').html(i + 1));
			_table.find('td.code').append(_hightlightedCode);
		}

		_table.find('td.code .found').each(function applyHighlighting() {
			$(this).removeClass('found').addClass(swapClassesForSyntaxHighlighting($(this),_patterns));
		});

		$(this).closest('pre').replaceWith(_table);
	});

	$('.admin-btn').on("click",function toggleAdminMenu() {
		$(this).children('.glyphicon').toggleClass('glyphicon-chevron-right').toggleClass('glyphicon-chevron-left');
		$('.admin-menu').toggleClass('open');
		$('body').toggleClass('admin-menu-open');
	});
});

function swapClassesForSyntaxHighlighting(_block,_patterns) {
	for (var j in _patterns) {
		var _regEx = new RegExp(_patterns[j].pattern,"gi");
		if (_block.html().match(_regEx)) {
			return _patterns[j].class;
		}
	}
	return "found";
}