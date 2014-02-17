/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/template.cfc
* @author  
* @description
*
*/

component output="false" displayname="template" extends="base" {

	VARIABLES.siteName = "";

	public template function init(){
		return super.init(ARGUMENTS);
	}


	public void function setSiteName(required string siteName) {
		VARIABLES.siteName = trim(ARGUMENTS.siteName);
	}


	public string function getSiteName() {
		return VARIABLES.siteName;
	}
}