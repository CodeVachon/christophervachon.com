$(document).ready(function initDom() {
	$('code').each(function eachCodeBlock() {
		var _table = $('<table>').addClass('syntax-highlighting').append(
		$('<tr>')
			.append($('<td>').addClass('gutter'))
			.append($('<td>').addClass('code')));

		var _code = $(this).html().split(/\r\n|\r|\n|<br(?:\s\/)?>/g);
		var _numLines = (_code.length - 1);

		var _patterns = [{
			class: 'const',
			pattern: "(?:(var|new|function|private|if|else)\\s)"
		}, {
			class: 'operator',
			pattern: "((?:[\\+\\-\\=\\!\\|\\(\\)\\{\\}]|&amp;){1,}|(?:[^\\*\\/]\\/(?!\\/|\\*)))"
		}, {
			class: 'comment',
			pattern: "\\/\\/[^\\(\\n|\\r)]+|\\/\\*|\\*\\/"
		}];
		var _computedRegExString = "";
		for (var k in _patterns) { _computedRegExString += _patterns[k].pattern + "|"; }
		_computedRegExString = "(" + _computedRegExString.replace(/\|$/, "") + ")";
		var _computedRegEx = new RegExp(_computedRegExString, "gi");

		for (var i = 0; i <= _numLines; i++) {
			var _hightlightedCode = _code[i];
			_hightlightedCode = _hightlightedCode.replace(_computedRegEx, "<span class='found'>$1</span>");
			_hightlightedCode = $('<div>').html(_hightlightedCode || "&nbsp;");
			_table.find('td.gutter').append($('<div>').html(i + 1));
			_table.find('td.code').append(_hightlightedCode);
		}

		_table.find('td.code .found').each(function applyHighlighting() {
			$(this).removeClass('found').addClass(swapClassesForSyntaxHighlighting($(this),_patterns));
		});

		$(this).replaceWith(_table);
	});
});

function swapClassesForSyntaxHighlighting(_block,_patterns) {
	var _className = "";
	for (var j in _patterns) {
		var _regEx = new RegExp(_patterns[j].pattern,"i");
		if (_block.html().match(_regEx)) {
			_className = _patterns[j].class;
		}
	}
	return _className;
}