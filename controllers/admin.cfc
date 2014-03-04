/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/admin.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	} //  close init


	public void function before( required struct rc) {
		RC.template.addPageCrumb("Admin","/admin");

		if ((RC.action != "admin.login") && !RC.security.checkPermission("siteAdmin")) {
			VARIABLES.fw.redirect(action='admin.login');
		}
	} // close before


	public void function default( required struct rc ) {
	} // close default


	public void function listPeople( required struct rc ) {
		RC.template.addPageCrumb("List People","/admin/listPeople");
		VARIABLES.fw.service( 'personService.getPeople', 'people');
	} // close listPeople


	public void function startEditPerson( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (structKeyExists(RC,"firstName") || structKeyExists(RC,"lastName")) {
				if (!structKeyExists(RC,"firstName") || !RC.validation.doesMatchMinStringRequirements(RC.firstName)) {
					arrayAppend(errors,"Invalid First Name [#RC.emailAddress#]");
				}
				if (!structKeyExists(RC,"lastName") || !RC.validation.doesMatchMinStringRequirements(RC.lastName)) {
					arrayAppend(errors,"Invalid Last Name [#RC.lastName#]");
				}
			} else if (!structKeyExists(RC,"password") || !RC.validation.doesPasswordValidate(RC.password)) {
				arrayAppend(errors,"Invalid Password Length");
			}

			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			} else {
				VARIABLES.fw.service( 'personService.editPersonAndSave', 'person');
			}
		} else {
			VARIABLES.fw.service( 'personService.getPerson', 'person');
		}
	}
	public void function editPerson( required struct rc ) {
		RC.template.addPageCrumb("List People","/admin/listPeople");
		RC.template.addPageCrumb("Edit Person","/admin/editPerson");
	}
	public void function endEditPerson( required struct rc ) {
		for (var property in RC.person.getPropertyStruct()) {
			if (!structKeyExists(RC,property)) {
				RC[property] = RC.person.getProperty(property);
			}
		}
	} // close editPerson


	public void function startEditEmailAddress( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (!structKeyExists(RC,"emailAddress") || !RC.validation.doesEmailValidate(RC.emailAddress)) {
				arrayAppend(errors,"Invalid Email Address [#RC.emailAddress#]");
			}
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
				VARIABLES.fw.service( 'personService.getEmailAddress', 'emailAddressObj');
			} else {
				VARIABLES.fw.service( 'personService.editEmailAddressAndSave', 'emailAddressObj');
			}
		} else {
			VARIABLES.fw.service( 'personService.getEmailAddress', 'emailAddressObj');
		}
	}
	public void function editEmailAddress( required struct rc ) {
		RC.template.addPageCrumb("List People","/admin/listPeople");
		RC.template.addPageCrumb("Edit Person","/admin/editPerson");
		RC.template.addPageCrumb("Edit Email Address","/admin/editEmailAddress");
	}
	public void function endEditEmailAddress( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && (!structKeyExists(RC,"validationError"))) {
			RC.personID = RC.emailAddressObj.getPerson().getID();
			VARIABLES.fw.redirect(action='admin.editPerson',append='personID');
		} else {
			for (var property in RC.emailAddressObj.getPropertyStruct()) {
				if (!structKeyExists(RC,property)) {
					RC[property] = RC.emailAddressObj.getProperty(property);
				}
			}
		}
	} // close editEmailAddress


	public void function startLogin( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (!structKeyExists(RC,"emailAddress") || !RC.validation.doesEmailValidate(RC.emailAddress)) {
				arrayAppend(errors,"Invalid Email Address [#RC.emailAddress#]");
			}
			if (!structKeyExists(RC,"password") || !RC.validation.doesPasswordValidate(RC.password)) {
				arrayAppend(errors,"Invalid Password Length");
			}
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			} else {
				param name="RC.rememberMe" default="off";
				RC.rememberMe = ((RC.rememberMe == "on")?true:false);
				VARIABLES.fw.service( 'security.signIn', 'didSignIn');
			}
		}
	}
	public void function login( required struct rc ) {
		RC.template.addPageCrumb("Login","/admin/login");
	}
	public void function endLogin ( required struct rc ) {
		if (structKeyExists(RC,"didSignIn") && RC.didSignIn) {
			VARIABLES.fw.redirect(action='admin');
		}
	} // close login


	public void function startLogout( required struct rc ) {
		VARIABLES.fw.service( 'security.signOut', 'didSignIn');
	}
	public void function endLogout( required struct rc ) {
		VARIABLES.fw.redirect(action='admin');
	} // close logout


	public void function listArticles( required struct rc ) {
		RC.template.addPageCrumb("List Articles","/admin/listArticles");
		RC.notBeforeDate = dateAdd("y",5,now());
		VARIABLES.fw.service( 'articleService.getArticles', 'articles');
	} // listArticles


	public void function startEditArticle( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (!structKeyExists(RC,"title") || !RC.validation.doesMatchMinStringRequirements(RC.title)) {
				arrayAppend(errors,"Invalid Title [#RC.title#]");
			}
			if (!structKeyExists(RC,"summary") || !RC.validation.doesMatchMinStringRequirements(RC.summary)) {
				arrayAppend(errors,"Invalid Summary [#RC.summary#]");
			}
			if (!structKeyExists(RC,"body") || !RC.validation.doesMatchMinStringRequirements(RC.body)) {
				arrayAppend(errors,"Invalid Body [#RC.body#]");
			}
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			} else {
				VARIABLES.fw.service( 'articleService.editArticleAndSave', 'article');
			}
		} else if (structKeyExists(RC,"articleID")) {
			VARIABLES.fw.service( 'articleService.getArticle', 'article');
		}
	}
	public void function editArticle( required struct rc ) {
		RC.template.addPageCrumb("List Articles","/admin/listArticles");
		RC.template.addPageCrumb("Edit Article","/admin/editArticle");
	}
	public void function endEditArticle( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && (!structKeyExists(RC,"validationError"))) {
			VARIABLES.fw.redirect(action='admin.listArticles');
		} else if (structKeyExists(RC,"article")) {
			for (var property in RC.article.getPropertyStruct()) {
				if (!structKeyExists(RC,property)) {
					RC[property] = RC.article.getProperty(property);
				}
			}
		}
	} // close editArticle
}

