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
	}


	public function init() { return this; }

	public function doesEmailValidate(required string emailAddress) {
		if (len(ARGUMENTS.emailAddress) > 0) {
			if (len(reReplace(ARGUMENTS.emailAddress,VARIABLES.REGEX.emailAddress,"","one")) == 0) {
				return true;
			}
		}
		return false;
	}
}