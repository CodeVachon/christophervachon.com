<cfscript>
	param name="RC.validationError" default="No error Passed!";

	LOCAL.errorTitle = "Oops!";
	LOCAL.errorMessage = "<p>No Soup For You!</p>";

	if (isStruct(RC.validationError)) {
		if (structKeyExists(RC.validationError,"errors")) {
			if (structKeyExists(RC.validationError,"label")) { LOCAL.errorTitle = RC.validationError.label; }
			LOCAL.errorMessage = "<ul>";
			for (LOCAL.error in RC.validationError.errors) {
				LOCAL.errorMessage &= "<li>#LOCAL.error#</li>";
			}
			LOCAL.errorMessage &= "<ul>";
		} else {
			LOCAL.errorMessage = "<ul>";
			for (LOCAL.key in RC.validationError.errors) {
				LOCAL.errorMessage &= "<li>#RC.validationError.errors[LOCAL.key]#</li>";
			}
			LOCAL.errorMessage &= "<ul>";
		}
	} else if (isArray(RC.validationError)) {
		LOCAL.errorMessage = "<ul>";
		for (LOCAL.error in RC.validationError) {
			LOCAL.errorMessage &= "<li>#LOCAL.error#</li>";
		}
		LOCAL.errorMessage &= "<ul>";
	} else if (isSimpleValue(RC.validationError)) {
		LOCAL.errorMessage = RC.validationError;
	} else {
		LOCAL.errorMessage = "<p>I dunno what do with this...</p>";
	}


</cfscript>
<cfoutput>
	<div class="alert alert-danger">
		<h3>#LOCAL.errorTitle#</h3>
		#LOCAL.errorMessage#
	</div>
</cfoutput>