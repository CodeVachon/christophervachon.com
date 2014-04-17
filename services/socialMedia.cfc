/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/socialMedia.cfc
* @author  Christopher Vachon
* @description unified interface and cache for social media feeds
*
*/

component output="false" displayname=""  {

	VARIABLES.websiteSettings = javaCast("Null","");

	public function init() { 

		if (structKeyExists(ARGUMENTS,"websiteSettings")) { this.setWebsiteSettings(ARGUMENTS.websiteSettings); }

		return this; 
	}


	public void function setWebsiteSettings(required models.websiteSettings websiteSettings) {
		VARIABLES.websiteSettings = ARGUMENTS.websiteSettings;
	} // close setWebsiteSettings


	public boolean function hasWebsiteSettings() {
		return (!isNull(VARIABLES.websiteSettings));
	} // close hasWebsiteSettings


	public models.websiteSettings function getWebsiteSettings() {
		if (this.hasWebsiteSettings()) {
			return VARIABLES.websiteSettings;
		} else {
			throw("Website Settings Not Set");
		}
	} // close getWebsiteSettings
}