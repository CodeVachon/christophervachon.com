/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/socialMedia.cfc
* @author  Christopher Vachon
* @description unified interface and cache for social media feeds
*
*/

component output="false" displayname=""  {

	VARIABLES.websiteSettings = javaCast("Null","");
	VARIABLES.twitter = javaCast("Null","");

	public function init() { 

		if (structKeyExists(ARGUMENTS,"websiteSettings")) { this.setWebsiteSettings(ARGUMENTS.websiteSettings); }

		return this; 
	} // close init


	public boolean function canConnectToTwitter() {
		if (this.hasWebsiteSettings()) {
			if (
				(len(this.getWebsiteSettings().getProperty("TW_UserName")) > 3) && 
				(len(this.getWebsiteSettings().getProperty("TW_ConsumerKey")) > 3) && 
				(len(this.getWebsiteSettings().getProperty("TW_ConsumerSecret")) > 3) && 
				(len(this.getWebsiteSettings().getProperty("TW_AccessToken")) > 3) && 
				(len(this.getWebsiteSettings().getProperty("TW_AccessTokenSecret")) > 3)
			) {
				return true;
			}
		}
		return false;
	} // close canConnectToTwitter


	public void function connectToTwitter() {
		if (this.canConnectToTwitter()) {
			VARIABLES.twitter = createObject('component','services.coldfumonkeh.monkehTweet').init(
				consumerKey			= this.getWebsiteSettings().getTW_ConsumerKey(),
				consumerSecret		= this.getWebsiteSettings().getTW_ConsumerSecret(),
				oauthToken			= this.getWebsiteSettings().getTW_AccessToken(),
				oauthTokenSecret 	= this.getWebsiteSettings().getTW_AccessTokenSecret(),
				userAccountName		= this.getWebsiteSettings().getTW_UserName(),
				parseResults		= true
			);
		} else {
			throw("Can Not Connect to Twitter");
		}
	} // close connectToTwitter


	public struct function getTwitterUserDetails(string screenName = this.getWebsiteSettings().getTW_UserName()) {
		var _details = this.getTwitter().getUserDetails(screen_name=ARGUMENTS.screenName);
		return _details;
	}


	public services.coldfumonkeh.monkehTweet function getTwitter() {
		if (isNull(VARIABLES.twitter)) { throw("Twitter is Not Connected"); }
		return VARIABLES.twitter;
	} // close getTwitter


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