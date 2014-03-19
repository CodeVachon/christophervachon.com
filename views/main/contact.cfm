<cfscript>
	param name="RC.validationErrors" default={};
</cfscript>
<cfoutput>
	<h2>Contact</h2>

	<cfif !structIsEmpty(RC.validationErrors)>
		<div class="alert alert-danger"><strong>Oops!</strong> Some errors where found.  Please correct them and send again</div>
	</cfif>

	<form name="contactMe" method="post" action="/contact" class='row'>
		<div class='form-group col-xs-12 col-md-6<cfif structKeyExists(RC.validationErrors,"firstName")> has-error</cfif>'>
			<label for="firstName" class='control-label'>First Name</label>
			<input type='text' name='firstName' id="firstName" class="form-control" value="#((structKeyExists(RC,"firstName"))?RC.firstName:"")#" />
			<cfif structKeyExists(RC.validationErrors,"firstName")><span class="help-block">#RC.validationErrors["firstName"]#</span></cfif>
		</div>
		<div class='form-group col-xs-12 col-md-6<cfif structKeyExists(RC.validationErrors,"lastName")> has-error</cfif>'>
			<label for="lastName" class='control-label'>Last Name</label>
			<input type='text' name='lastName' id="lastName" class="form-control" value="#((structKeyExists(RC,"lastName"))?RC.lastName:"")#" />
			<cfif structKeyExists(RC.validationErrors,"lastName")><span class="help-block">#RC.validationErrors["lastName"]#</span></cfif>
		</div>
		<div class='form-group col-xs-12 col-md-8<cfif structKeyExists(RC.validationErrors,"emailAddress")> has-error</cfif>'>
			<label for="emailAddress" class='control-label'>E-Mail Address</label>
			<input type='text' name='emailAddress' id="emailAddress" class="form-control" value="#((structKeyExists(RC,"emailAddress"))?RC.emailAddress:"")#" />
			<cfif structKeyExists(RC.validationErrors,"emailAddress")><span class="help-block">#RC.validationErrors["emailAddress"]#</span></cfif>
		</div>
		<div class='form-group col-xs-12<cfif structKeyExists(RC.validationErrors,"subject")> has-error</cfif>'>
			<label for="subject" class='control-label'>Subject</label>
			<input type='text' name='subject' id="subject" class="form-control" value="#((structKeyExists(RC,"subject"))?RC.subject:"")#" />
			<cfif structKeyExists(RC.validationErrors,"subject")><span class="help-block">#RC.validationErrors["subject"]#</span></cfif>
		</div>
		<div class='form-group col-xs-12<cfif structKeyExists(RC.validationErrors,"body")> has-error</cfif>'>
			<label for="body" class='control-label'>Your Message</label>
			<cfif structKeyExists(RC.validationErrors,"body")><span class="help-block">#RC.validationErrors["body"]#</span></cfif>
			<textarea name="body" id="body" data-wysiwyg='basic' class="form-control" rows="7">#((structKeyExists(RC,"body"))?RC.body:"")#</textarea>
		</div>
		<div class='form-group col-xs-12 col-md-6'>
			<input type='submit' name="btnSave" value="Send" class='btn btn-primary btn-lg' />
		</div>
	</form>
</cfoutput>