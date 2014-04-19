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

	VARIABLES.cache = {};

	public function init() { 

		if (structKeyExists(ARGUMENTS,"websiteSettings")) { this.setWebsiteSettings(ARGUMENTS.websiteSettings); }

		if (this.canConnectToTwitter()) { this.connectToTwitter(); }

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
		if (this.isConnectedToTwitter()) {
			if (!structKeyExists(VARIABLES.cache,"twitter")) { VARIABLES.cache.twitter = {}; }
			if (!structKeyExists(VARIABLES.cache.twitter,"userDetails")) { VARIABLES.cache.twitter.userDetails = {}; }
			if (!structKeyExists(VARIABLES.cache.twitter.userDetails, ARGUMENTS.screenName)) {
				VARIABLES.cache.twitter.userDetails[ARGUMENTS.screenName] = this.getTwitter().getUserDetails(screen_name=ARGUMENTS.screenName);
			}
			return VARIABLES.cache.twitter.userDetails[ARGUMENTS.screenName];
		}
	}


	public array function getTwitterUserFeed(string screenName = this.getWebsiteSettings().getTW_UserName(), numeric itemCount = 5) {
		if (this.isConnectedToTwitter()) {
			return this.getTwitter().getUserTimeline(screen_name=ARGUMENTS.screenName,count=ARGUMENTS.itemCount);
		}
	}


	public services.coldfumonkeh.monkehTweet function getTwitter() {
		if (!this.isConnectedToTwitter()) { throw("Twitter is Not Connected"); }
		return VARIABLES.twitter;
	} // close getTwitter


	public boolean function isConnectedToTwitter() {
		return (!isNull(VARIABLES.twitter));
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