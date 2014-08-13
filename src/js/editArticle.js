var _toggleLibraries = true;
var _s3Bucket = "christophervachon";

var _s3Data = {};

$(document).ready(function() {
	$('.amazonS3-upload-form').hide();
	$('[name="body"]').on('change',function() {
		fnUpdatePreview();
	});
	$('.previewPane').on('click','a',function(e) {
		e.preventDefault();
		alert("Click to " + $(this).prop("href") + " Prevented!");
	});

	$('.s3-library').on('click',function(e) {
		e.preventDefault();
		console.log("open  s3");
		var _thisButton = $(this);
		var _awsContent = loadS3Files();

		var _uploadForm = $('.amazonS3-upload-form').addClass('pull-left').show();
		var _uploadURL = _uploadForm.prop("action");

		console.log("upload to: " + _uploadURL);

		var _dialog = $('<div>').addClass('modal fade')
			.append($('<div>').addClass('modal-dialog modal-lg')
				.append($('<div>').addClass('modal-content')
					.append($('<div>').addClass('modal-header')
						.append($('<button>').addClass('close').attr('data-dismiss','modal').append($('<span>').html('&times;')))
						.append($('<h4>').addClass('modal-title').html("S3 Library"))
					) // close modal-header
					.append($('<div>').addClass('modal-body')
						.append(_awsContent)
					) // close modal-body
					.append($('<div>').addClass('modal-footer')
						.append(_uploadForm)
						.append($('<button>').addClass('btn btn-primary').attr('data-dismiss','modal').html("Close"))
					) // close modal-footer
				)
			);
		_dialog.modal('show');

		_uploadForm.on('submit', function(event){
			//console.log(this);
			_awsContent.html("Uploading...");
			var data = new FormData(this);
			//console.log(data);
			var xhr = new XMLHttpRequest();
			var _btn = _uploadForm.find('button');
			_btn.addClass('disabled');
			xhr.upload.addEventListener('progress',function(ev){
				//console.log(ev);
			}, false);
			xhr.onreadystatechange = function(ev){
				//console.log(ev);
				if(xhr.readyState == 4){
					_awsContent.html(loadS3Files());
					_uploadForm.find('input[name="file"]').val("");
					_btn.removeClass('disabled');
				}
			};
			xhr.open('POST', _uploadURL, true);
			xhr.send(data);
			return false;
		});
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

function fnSortAWSKeys(_awsData) {
	var _logName = "sortAWSKeys";
	console.groupCollapsed(_logName);
	console.log("Sort AWS Keys");

	console.log('Data: ');
	console.log(_awsData);

	var _tmp = {};
	var _arrayLen = _awsData.length;
	for (var i=0;i<_arrayLen;i++) {
		var _key = _awsData[i].Key;
		console.log("Parse Key:" + _key);
		var _splitPath = _key.split("/");
		console.log(_splitPath);
		var _splitPathLen = _splitPath.length;
		var _filePath = "";
		for (var j=0;j<_splitPathLen;j++) {
			var _name = _splitPath[j];
			if (_name.length > 0) {
				if (fnIsFile(_name)) {
					console.log(_name + " is a File");
					_current = deepFind(_tmp,_filePath.replace(/\.$/,""));
					_current[_name] =_awsData[i];
				} else {
					console.log(_name + " is a Folder");
					_current = deepFind(_tmp,_filePath.replace(/\.$/,""));
					if (!_current[_name]) _current[_name] = {};
					_filePath += _name + "." ;
					console.log("set new path: " + _filePath);
				}
			}
		}
	}
	console.groupEnd(_logName);
	return _tmp;
}

function deepFind(obj, path) {
	var paths = path.split('.');
	var current = obj;

	for (var i = 0; i < paths.length; ++i) {
		if (!current[paths[i]]) {
			console.log(current[paths[i]] + " Error");
			//return ;
		} else {
			current = current[paths[i]];
		}
	}
	return current;
}

function fnIsFile(fileName) {
	return fileName.match(/\.[a-zA-Z0-9_]{2,5}/gi);
}

function fnDrawFolderList(_fileStruct) {
	var _struct = $('<ul>');
	for (var _key in _fileStruct) {
		var _anchor = $('<a>').prop({"href":"#"}).html(_key);
		var _listItem = $('<li>').html(_anchor);
		if (!fnIsFile(_key)) {
			_anchor.addClass('folder').prepend($('<span>').addClass('glyphicon glyphicon-folder-close')).on("click",toggleFolders);
			_listItem.append(fnDrawFolderList(_fileStruct[_key]).addClass('closed').hide());
		} else {
			console.log(_fileStruct[_key]);
			_anchor.addClass('file')
				.prepend($('<span>').addClass('glyphicon glyphicon-picture'))
				.attr('data-img-url',"https://s3.amazonaws.com/" + _s3Bucket + "/" + _fileStruct[_key].Key)
				.on("click",showFileDetails);
		}
		_struct.append(_listItem);
	}
	return _struct;
}

function toggleFolders(e) {
	e.preventDefault();
	var _ul = $(this).next('ul');
	if (_ul.hasClass('closed')) {
		_ul.removeClass('closed').show();
		$(this).children('.glyphicon').removeClass('glyphicon-folder-close').addClass("glyphicon-folder-open");
	} else {
		_ul.addClass('closed').hide();
		$(this).children('.glyphicon').removeClass('glyphicon-folder-open').addClass("glyphicon-folder-close");
	}
}

function showFileDetails(e) {
	e.preventDefault();
	$(this).closest('.file-selector').find('.active').removeClass('active');
	$(this).addClass('active');
	var _image = $('<img>').addClass("previewImage").prop({"src":$(this).attr('data-img-url'),"alt":$(this).text()});
	var _valueBox = $('<input>').addClass("form-control").prop({"type":"text","readonly":true}).val($(this).attr('data-img-url'));
	$(".file-information").html("")
		.append($('<p>').html($(this).text()))
		.append(_image)
		.append(_valueBox);
}

function loadS3Files() {
	var _body = $('<div>').html('Loading...');
	var s3bucket = new AWS.S3({ params: {Bucket: _s3Bucket} });

	params = {};
	s3bucket.listObjects(params, function(err, data) {
		if (err)  {
			console.log(err, err.stack); // an error occurred
			_body.html($('<div>').addClass('alert alert-danger').html("An Error Occured Contacting S3. View Console for Details"));
		} else {
			_s3Data = fnSortAWSKeys(data.Contents);

			var fileExplorer = $("<div>").addClass('file-explorer row')
				.append($('<div>').addClass('file-selector col-xs-8').html(fnDrawFolderList(_s3Data)))
				.append($('<div>').addClass('file-information col-xs-4').html("Select a File"))
			;
			_body.html(fileExplorer);
		}
	});
	return _body;
}
