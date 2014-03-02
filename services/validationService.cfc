/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/validationService.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {


	VARIABLES.REGEX = {
		emailAddress = "^[a-zA-Z][a-zA-Z0-9\+\._-]{2,}@[a-zA-Z0-9\._-]{2,}\.[a-zA-Z]{2,6}$"
	};


	public function init() { return this; }


	public boolean function doesEmailValidate(required string value) {
		if (len(ARGUMENTS.value) > 0) {
			if (len(reReplace(ARGUMENTS.value,VARIABLES.REGEX.emailAddress,"","one")) == 0) {
				return true;
			}
		}
		return false;
	}


	public boolean function doesPasswordValidate(required string value) {
		if (len(ARGUMENTS.value) >= 2) {
			return true;
		}
		return false;
	}


	public boolean function doesMatchMinStringRequirements(required string value) {
		if (len(ARGUMENTS.value) > 0) {
			return true;
		}
		return false;
	}
}