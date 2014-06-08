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
		RC.adminScreen = true;

		if ((RC.action != "admin.login") && !RC.security.checkPermission("siteAdmin")) {
			VARIABLES.fw.redirect(action='admin.login');
		}

		REQUEST.CONTEXT.template.addFile("//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js");
		REQUEST.CONTEXT.template.addFile("christophervachon.min.css");
		REQUEST.CONTEXT.template.addFile("//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css");
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
				var articleService = new services.articleService();
				RC.article = articleService.editArticleAndSave(RC);
				var searchService = new services.searchService(APPLICATION.blogCollectionName);
				searchService.updateIndex(id=RC.article.getID(), title=RC.article.getTitle(), body=RC.article.getBody(), custom1=RC.article.getTagNamesAsList());
			}
		} else if (structKeyExists(RC,"articleID")) {
			VARIABLES.fw.service( 'articleService.getArticle', 'article');
		}
	}
	public void function editArticle( required struct rc ) {
		RC.template.addPageCrumb("List Articles","/admin/listArticles");
		RC.template.addPageCrumb("Edit Article","/admin/editArticle");
		RC.template.addFile('/includes/js/formOptions.js');
		RC.template.addFile("/includes/js/jquery.syntaxhighlighter.min.js");
		RC.template.addFile("/includes/js/editArticle.js");
	}
	public void function endEditArticle( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && (!structKeyExists(RC,"validationError"))) {
			location(url='/blog/#RC.article.getURI()#',addToken=false);
		} else if (structKeyExists(RC,"article")) {
			for (var property in RC.article.getPropertyStruct()) {
				if (!structKeyExists(RC,property)) {
					RC[property] = RC.article.getProperty(property);
				}
			}
			RC.articleTags = "";
			for (var _tag in RC.article.getTags()) {
				RC.articleTags = listAppend(RC.articleTags,_tag.getName());
			}
		}

		REQUEST.disableSidebar = true;
	} // close editArticle


	public void function previewArticle( required struct rc ) {
		var articleService = new services.articleService();
		RC.article = articleService.editArticle(RC);
		VARIABLES.fw.setView("blog.view");
		REQUEST.layout = false;
	} // close previewArticle


	public void function listTags( required struct rc ) {
		RC.template.addPageCrumb("List Tags","/admin/listTags");
		VARIABLES.fw.service( 'articleService.getTags', 'tags');
	} // close listTags


	public void function startEditTag( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (!structKeyExists(RC,"name") || !RC.validation.doesMatchMinStringRequirements(RC.name)) {
				arrayAppend(errors,"Invalid Tag Name [#RC.name#]");
			}
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			} else {
				VARIABLES.fw.service( 'articleService.editTagAndSave', 'tag');
			}
		} else if (structKeyExists(RC,"tagID")) {
			VARIABLES.fw.service( 'articleService.getTag', 'tag');
		}
	}
	public void function editTag( required struct rc ) {
		RC.template.addPageCrumb("List Tags","/admin/listTags");
		RC.template.addPageCrumb("Edit Tag","/admin/editTag");
		RC.template.addFile('/includes/js/formOptions.js');
	}
	public void function endEditTag( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && (!structKeyExists(RC,"validationError"))) {
			location(url='/admin/listTags',addToken=false);
		} else if (structKeyExists(RC,"tag")) {
			for (var property in RC.tag.getPropertyStruct()) {
				if (!structKeyExists(RC,property)) {
					RC[property] = RC.tag.getProperty(property);
				}
			}
		}
	} // close editTag


	public void function rebuildSearchIndex( required struct rc ) {
		RC.template.addPageCrumb("Rebuild Search Index","/admin/rebuildSearchIndex");

		var articleService = new services.articleService();
		RC.articles = articleService.getArticles(itemsPerPage=2500);
		var searchService = new services.searchService(APPLICATION.blogCollectionName);
		RC.searchResults = searchService.loadIndex(entityToQuery(RC.articles));
	} // close rebuildSearchIndex


	public void function startSettings( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			VARIABLES.fw.service( 'websiteSettingsService.editWebsiteSettingsAndSave', 'websiteSettings');
		}
	}
	public void function settings( required struct rc ) {
		RC.template.addPageCrumb("Website Settings","/admin/settings");
	}
	public void function endSettings( required struct rc ) {
		if (structKeyExists(RC,"btnSave")) {
			APPLICATION.websiteSettings = RC.websiteSettings;
		}
		for (var property in APPLICATION.websiteSettings.getPropertyStruct()) {
			if (!structKeyExists(RC,property)) {
				RC[property] = APPLICATION.websiteSettings.getProperty(property);
			}
		}
		RC.websiteSettingsID = APPLICATION.websiteSettings.getID();
	} // close settings


	public void function listContentPages( required struct rc ) {
		RC.template.addPageCrumb("List Content Pages","/admin/listContentPages");
		VARIABLES.fw.service( 'contentService.getContents', 'contentPages');
	} // close listContentPages


	public void function startEditContentPage( required struct rc ) {
		var contentService = new services.contentService();
		if (structKeyExists(RC,"btnSave")) {
			var errors = [];
			if (arrayLen(errors) > 0) {
				RC.validationError = errors;
			} else {
				RC.content = contentService.editContentAndSave(RC);
			}
		} else if (structKeyExists(RC,"contentId")) {
			RC.content = contentService.getContent(RC);
		}
	}
	public void function editContentPage( required struct rc ) {
		RC.template.addPageCrumb("List Content Pages","/admin/listContentPages");
		RC.template.addPageCrumb("Edit Content Page","/admin/editContentPage");
		RC.template.addFile('/includes/js/formOptions.js');
	}
	public void function endEditContentPage( required struct rc ) {
		if (structKeyExists(RC,"btnSave") && (!structKeyExists(RC,"validationError"))) {
			location(url='/admin/listContentPages',addToken=false);
		} else if (structKeyExists(RC,"content")) {
			for (var property in RC.content.getPropertyStruct()) {
				if (!structKeyExists(RC,property)) {
					RC[property] = RC.content.getProperty(property);
				}
			}
		}
	} // close editContentPage
}
