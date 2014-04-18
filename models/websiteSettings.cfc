/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/websiteSettings.cfc
* @author  
* @description
*
*/

component output="false" displayname="websiteSettings" persistent="true" extends="ormbase" table="websiteSettings" {

	property name="domain" type="string" setter="false";
	property name="siteName" type="string";
	property name="description" type="string";

	property name="Mail_SMTPServer" type="string";
	property name="Mail_Port" type="string";
	property name="Mail_Username" type="string";
	property name="Mail_Password" type="string";
	property name="Mail_UseSSL" type="boolean";

	property name="Mail_FromName" type="string";
	property name="Mail_FromEmailAddress" type="string";
	property name="Mail_SendToEmailAddress" type="string";


	// Twitter Connection Information 
	property name="TW_ConsumerKey" type="string";
	property name="TW_ConsumerSecret" type="string";
	property name="TW_AccessToken" type="string";
	property name="TW_AccessTokenSecret" type="string";
	property name="TW_UserName" type="string";


	public function init(){ return super.init(); }


	public void function refreshProperties() {
		super.refreshProperties();

		if (!structKeyExists(VARIABLES,"domain")) { VARIABLES["domain"] = CGI.SERVER_NAME; }
		if (!structKeyExists(VARIABLES,"siteName")) { VARIABLES["siteName"] = "My Site"; }
		if (!structKeyExists(VARIABLES,"description")) { VARIABLES["description"] = "This is a blog Site"; }

		if (!structKeyExists(VARIABLES,"Mail_SMTPServer")) { VARIABLES["Mail_SMTPServer"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_Port")) { VARIABLES["Mail_Port"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_Username")) { VARIABLES["Mail_Username"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_Password")) { VARIABLES["Mail_Password"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_UseSSL")) { VARIABLES["Mail_UseSSL"] = false; }

		if (!structKeyExists(VARIABLES,"Mail_FromName")) { VARIABLES["Mail_FromName"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_FromEmailAddress")) { VARIABLES["Mail_FromEmailAddress"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"Mail_SendToEmailAddress")) { VARIABLES["Mail_SendToEmailAddress"] = javaCast("null",""); }

		if (!structKeyExists(VARIABLES,"TW_ConsumerKey")) { VARIABLES["TW_ConsumerKey"] = ""; }
		if (!structKeyExists(VARIABLES,"TW_ConsumerSecret")) { VARIABLES["TW_ConsumerSecret"] = ""; }
		if (!structKeyExists(VARIABLES,"TW_AccessToken")) { VARIABLES["TW_AccessToken"] = ""; }
		if (!structKeyExists(VARIABLES,"TW_AccessTokenSecret")) { VARIABLES["TW_AccessTokenSecret"] = ""; }
		if (!structKeyExists(VARIABLES,"TW_UserName")) { VARIABLES["TW_UserName"] = ""; }
	}
}