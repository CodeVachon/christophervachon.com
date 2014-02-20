/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/application.cfc
* @author  
* @description
*
*/

component extends="frameworks.org.corfield.framework" {

	this.name = 'ChristopherVachonVr0.0.1';
	this.sessionManagement = true;
	this.sessionTimeout = CreateTimespan(0,0,20,0);

	VARIABLES.framework = {
		generateSES = true,
		SESOmitIndex = true,
		applicationKey = 'fw1',
		reloadApplicationOnEveryRequest = true
	};


	public string function getEnvironment() {
		if (reFindNoCase("\.(local)$",CGI.SERVER_NAME) > 0) {
			return "dev";
		} else {
			return "live";
		}
	}


	public void function setupApplication() {}


	public void function setupRequest() {
		REQUEST.CONTEXT.template = new models.template();
		REQUEST.CONTEXT.template.setSiteName("Christopher Vachon");
	}


	public string function onMissingView( required struct rc ) {}
}