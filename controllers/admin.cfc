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


	public void function login( required struct rc ) {
		RC.template.addPageCrumb("Login","/Admin/Login");
	}
}