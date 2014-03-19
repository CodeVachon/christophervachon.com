/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/main.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	}


	public void function before( required struct rc ) {
	}


	public void function default( required struct rc ) {
	}


	public void function startContact( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = {};
			if (!structKeyExists(RC,"emailAddress") || !RC.validation.doesEmailValidate(RC.emailAddress)) {
				errors["emailAddress"] = "Invalid Email Address Length";
			}
			if (!structKeyExists(RC,"firstName") || !RC.validation.doesMatchMinStringRequirements(RC.firstName)) {
				errors["firstName"] = "Invalid First Name Length";
			}
			if (!structKeyExists(RC,"lastName") || !RC.validation.doesMatchMinStringRequirements(RC.lastName)) {
				errors["lastName"] = "Invalid Last Name Length";
			}
			if (!structKeyExists(RC,"subject") || !RC.validation.doesMatchMinStringRequirements(RC.subject)) {
				errors["subject"] = "Invalid Subject Length";
			}
			if (!structKeyExists(RC,"body") || !RC.validation.doesMatchMinStringRequirements(RC.body)) {
				errors["body"] = "Invalid Body Length";
			}

			if (structIsEmpty(errors)) {
				// Send Mail
			} else {
				RC.validationErrors = errors;
			}
		}
	}
	public void function contact( required struct rc ) {
		RC.template.addPageCrumb("Contact","/contact");
	}
}