/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/main.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	}


	public void function before( required struct rc ) {
		REQUEST.CONTEXT.template.addFile("cmvVirt.min.css");
		REQUEST.CONTEXT.template.addFile("cmvVirt.js");
	}


	public void function default( required struct rc ) {
		var articleService = new services.articleService();
		RC.articles = articleService.getArticles(itemsPerPage=5);
	}


	public void function startContact( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = {};
			if (!structKeyExists(RC,"emailAddress") || !RC.validation.doesEmailValidate(RC.emailAddress)) {
				errors["emailAddress"] = "Invalid Email Address Length";
			}
			if (!structKeyExists(RC,"firstName") || !RC.validation.doesMatchMinStringRequirements(RC.firstName)) {
				errors["firstName"] = "Invalid First Name Length";
			}
			if (!structKeyExists(RC,"lastName") || !RC.validation.doesMatchMinStringRequirements(RC.lastName)) {
				errors["lastName"] = "Invalid Last Name Length";
			}
			if (!structKeyExists(RC,"subject") || !RC.validation.doesMatchMinStringRequirements(RC.subject)) {
				errors["subject"] = "Invalid Subject Length";
			}
			if (!structKeyExists(RC,"body") || !RC.validation.doesMatchMinStringRequirements(RC.body)) {
				errors["body"] = "Invalid Body Length";
			}

			if (structIsEmpty(errors)) {
				RC.SMTPServer = APPLICATION.websiteSettings.getProperty("Mail_SMTPServer");
				RC.SMTPPort = APPLICATION.websiteSettings.getProperty("Mail_Port");
				RC.SMTPUsername = APPLICATION.websiteSettings.getProperty("Mail_Username");
				RC.SMTPPassword = APPLICATION.websiteSettings.getProperty("Mail_Password");
				RC.SMTPuseSSL = APPLICATION.websiteSettings.getProperty("Mail_UseSSL");

				RC.SMTPFromName = APPLICATION.websiteSettings.getProperty("Mail_FromName");
				RC.SMTPFromEmailAddress = APPLICATION.websiteSettings.getProperty("Mail_FromEmailAddress");
				RC.toAddress = APPLICATION.websiteSettings.getProperty("Mail_SendToEmailAddress");

				RC.content = "<h1>Website Message</h1><p>From: #RC.firstName# #RC.lastName# [<a href='mailto:#RC.emailAddress#'>#RC.emailAddress#</a>]<br/></p>#RC.body#";

				var mailService = new services.mailService();
				mailService.sendEmail(RC);
			} else {
				RC.validationErrors = errors;
			}
		}
	}
	public void function contact( required struct rc ) {
		RC.template.addPageCrumb("Contact","/contact");
	}
	public void function endContact( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && !structKeyExists(RC,"validationErrors")) {
			VARIABLES.fw.redirect(action='message-sent');
		}
	} // close contact
}