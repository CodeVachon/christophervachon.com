var _FBInit = false;

$(document).ready(function() {
	$('form').each(function() {
		var _form = $(this);
		if (_form.find("[data-datepicker]").size() > 0) {
			console.log("Date Picker Found");
			loadFileForFN("/includes/js/bootstrap-datepicker.js","datepicker").done(function() {
				_form.find("[data-datepicker]").each(function() {
					console.log("Add Datepicker to: " + $(this).attr("name"));
					var _options = {"format":"yyyy/mm/dd","todayBtn": true};
					$(this).datepicker(_options);
				});
			});
		} // close if date-picker


		if (_form.find("[data-timepicker]").size() > 0) {
			console.log("Time Picker Found");
			loadFileForFN("/includes/js/bootstrap-timepicker.min.js","timepicker").done(function() {
				_form.find("[data-timepicker]").each(function() {
					console.log("Add Timepicker to: " + $(this).attr("name"));
					var _options = {"showMeridian":false};
					$(this).timepicker(_options);
				});
			});
		} // close if time-picker


		if (_form.find("[data-wysiwyg]").size() > 0) {
			console.log("wysiwyg Found");
			loadFileForFN("/includes/js/tinymce/jquery.tinymce.min.js","tinymce").done(function() {
				_form.find("[data-wysiwyg]").each(function() {
					console.log("Add wysiwyg to [" + $(this).attr("data-wysiwyg") + "]: " + $(this).attr("name"));
					var _options = {
						script_url: '/includes/js/tinymce/tinymce.min.js',
						width:      '100%',
						height:     200,
						menubar:    false
					};
					if ($(this).attr("data-wysiwyg") == "basic") {
						_options.plugins = "link";
						_options.statusbar = false;
						_options.toolbar = "bold italic underline | link unlink";
					} else {
						_options.plugins = "link, code, fullscreen, visualblocks";
						_options.statusbar = true;
						_options.toolbar = "fullscreen | visualblocks code | undo redo | bold italic underline strikethrough | link unlink | blockquote | bullist numlist ";
					}
					$(this).tinymce(_options);
				});
			});
		} // close if data-wysuwyg


		if (_form.find("[data-fbquery]").size() > 0) {
			console.log("Facebook Query Lookup Found");
			loadFileForFN("//connect.facebook.net/en_UK/all.js","FB").done(function() {
				_form.find("[data-fbquery]").each(function() {
					console.log("Add fbquery to: " + $(this).attr("name"));
					var _this = $(this);
					_this.wrap($('<div>').addClass('input-group'))
						.after(
							$('<span>').addClass('input-group-btn')
								.append(
									$('<button>').addClass('btn btn-default').prop('type','button')
										.append($('<span>').addClass('glyphicon glyphicon-list-alt'))
										.on('click', function(e) {
											e.preventDefault();
											console.log("Facebook Query Request");
											if (!_FBInit) {
												FB.init({
													appId: '272812729524274',
													channelUrl: '//www.finealley.com/channel.html',
												});
												_FBInit = true;
											}
											FB.getLoginStatus(function(response) {
												if (response.authResponse) { 
													_accessToken = response.authResponse.accessToken; 
													FB.api(_this.attr('data-fbquery') + '&access_token=' + _accessToken, function(json) {
														console.log(json);
														if (json[_this.attr('data-fbkey')]) {
															var _content = $('<form>');
															for (var key in json[_this.attr('data-fbkey')].data) {
																_content.append(
																	$('<div>').addClass('radio')
																		.append(
																			$('<label>')
																				.append($('<input>').prop({
																					type: "radio",
																					name: "eventId",
																					value: json[_this.attr('data-fbkey')].data[key].id
																				})).append(json[_this.attr('data-fbkey')].data[key].name)
																		)
																); // close _content.append
															}// close for each

															dialog({
																title: "Select Facebook Event",
																content: _content,
																buttons: {
																	"Select": {
																		class: "btn btn-primary",
																		onClick: function(e) {
																			_this.val(_content.find(":checked").val());
																		}
																	},
																	"Cancel": function() { console.log('Cancel'); }
																}
															}); // close dialog
														} // close if key
													}); // close FB.api
												} else {
													console.log('Not Authenticated');
												}
											});
										}) // close on click
								) // close append span
						); // close after
				}); // close find fbquery
			}); // close .done
		} // close if data-fbquery
	});
});


function loadFileForFN(_src,_fnName) {
	var d = $.Deferred();
	if ($.isFunction(_fnName)) {
		console.log('found: ' + _fnName);
		d.resolve();
	} else {
		console.log('Fetch: ' + _src);
		$.getScript(_src, function( data, textStatus, jqxhr ) {
			console.log('Fetch Complete: ' + _src);
			d.resolve();
		}).fail(function(e) {
			console.log("Failed to Laod: " + _src);
			console.log(e);
			d.reject();
		});
	}
	return d.promise();
}


function dialog(arg) {
	var _title = ((arg.title)?arg.title:"Dialog");
	var _content = ((arg.content)?arg.content:"No Content");
	var _buttons = $('<div>').addClass('modal-footer');
	if (arg.buttons) {
		for (var _button in arg.buttons) {
			if ($.isFunction(arg.buttons[_button])) {
				_buttons.append(
					$('<button>')
						.attr({"data-dismiss":"modal","type":"button"})
						.html(_button)
						.addClass('btn btn-default')
						.on("click",arg.buttons[_button])
				);
			} else {
				_buttons.append(
					$('<button>')
						.attr({"data-dismiss":"modal","type":"button"})
						.html(_button)
						.addClass( ((arg.buttons[_button].class)?arg.buttons[_button].class:'btn btn-default') )
						.on("click",arg.buttons[_button].onClick)
				);
			}
		}
	} else {
		_buttons.append($('<button>').attr({"data-dismiss":"modal","type":"button"}).text("Close").addClass('btn btn-default'));
	} // close if arg.button

	return $('<div>').addClass('modal fade').append(
			$('<div>').addClass('modal-dialog').append(
				$('<div>').addClass('modal-content')
					.append(
						$('<div>').addClass('modal-header')
							.append($('<button>').addClass('close').attr({"type": "button","data-dismiss":"modal","aria-hidden":true}).html('&times;'))
							.append($('<h4>').addClass('modal-title').html(_title))
					).append(
						$('<div>').addClass('modal-body')
							.append(_content)
					).append(_buttons)
			)
		).modal('show').on('hidden.bs.modal', function (e) {
			$(this).remove();
		});
}