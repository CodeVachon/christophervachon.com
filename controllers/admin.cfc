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
		RC.template.addPageCrumb("Admin","/admin");

		if ((RC.action != "admin.login") && !RC.security.checkPermission("siteAdmin")) {
			VARIABLES.fw.redirect(action='admin.login');
		}
	}


	public void function default( required struct rc ) {
	}


	public void function editPerson( required struct rc ) {
		RC.template.addPageCrumb("Edit Person","/admin/editPerson");
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
			} else {
				VARIABLES.fw.service( 'security.signIn', 'didSignIn');
			}
		}
	}
	public void function login( required struct rc ) {
		RC.template.addPageCrumb("Login","/admin/login");
	}
	public void function endLogin ( required struct rc ) {
		if (structKeyExists(RC,"didSignIn") && RC.didSignIn) {
			VARIABLES.fw.redirect(action='admin');
		}
	} // close login
}