/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/mailService.cfc
* @author  
* @description
*
*/

component output="false" displayname="mailService" extends="base" {

	public function init() { return super.init(); }


	public void function sendEmail() {
		if ((structCount(ARGUMENTS) == 1) && structKeyExists(ARGUMENTS,"1")) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var mail = new mail();
		mail.setSubject((structKeyExists(ARGUMENTS,"subject"))?ARGUMENTS.subject:"Unknown Subject");
		mail.setTo((structKeyExists(ARGUMENTS,"toAddress"))?ARGUMENTS.toAddress:"Unknown Address");

		mail.setType("HTML");

		if (structKeyExists(ARGUMENTS,"SMTPServer")) { mail.setServer(ARGUMENTS["SMTPServer"]); }
		if (structKeyExists(ARGUMENTS,"SMTPPort")) { mail.setPort(ARGUMENTS["SMTPPort"]); }
		if (structKeyExists(ARGUMENTS,"SMTPUsername")) { mail.setUsername(ARGUMENTS["SMTPUsername"]); }
		if (structKeyExists(ARGUMENTS,"SMTPPassword")) { mail.setPassword(ARGUMENTS["SMTPPassword"]); }
		if (structKeyExists(ARGUMENTS,"SMTPuseSSL")) { mail.setUseSSL(ARGUMENTS["SMTPuseSSL"]); }

		if (structKeyExists(ARGUMENTS,"SMTPFromName")) { mail.setFrom(ARGUMENTS["SMTPFromName"] & " <#((structKeyExists(ARGUMENTS,"SMTPFromEmailAddress"))?ARGUMENTS["SMTPFromEmailAddress"]:"no-reply@#lCase(CGI.SERVER_NAME)#")#>"); }
		if (structKeyExists(ARGUMENTS,"SMTPFromEmailAddress")) { mail.setReplyto(ARGUMENTS["SMTPFromEmailAddress"]); }

		if (structKeyExists(ARGUMENTS,"content")) { mail.setBody(ARGUMENTS["content"]); }  

		mail.setspoolenable(true);
		mail.setTimeout("300");
		mail.setuseTLS("false");

		try {
			mail.send();
		} catch (any e) {
			writeDump(e);
			abort;

			throw(message="Failed to Send Message");
		}
	} // close sendEmail
}
