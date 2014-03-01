/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/admin.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	}


	public void function before( required struct rc) {
		RC.template.addPageCrumb("Home","/");
		RC.template.addPageCrumb("Admin","/Admin");

		if ((RC.action != "admin.login") && !RC.security.checkPermission("isAdmin")) {
			VARIABLES.fw.redirect(action='admin.login');
		}
	}


	public void function default( required struct rc ) {
	}


	public void function startLogin( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (!structKeyExists(RC,"emailAddress") || !RC.validation.doesEmailValidate(RC.emailAddress)) {
				arrayAppend(errors,"Invalid Email Address [#RC.emailAddress#]");
			}
			if (!structKeyExists(RC,"password") || !RC.validation.doesPasswordValidate(RC.password)) {
				arrayAppend(errors,"Invalid Password Length");
			}
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			}
		}
	}
	public void function login( required struct rc ) {
		RC.template.addPageCrumb("Login","/Admin/Login");
	}
}