/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/article.cfc
* @author  
* @description
*
*/

component output="false" displayname="article" extends="ormbase" table="articles" persistent="true" {

	property name="title" type="string";
	property name="summary" type="string" length="750";
	property name="body" type="string" length="50000";
	property name="markdown" type="string" length="50000";
	property name="publicationDate" type="datetime" ormtype="timestamp";

	property name="uriStrings" setter="false" fieldtype="collection" type="array" table="articles_uris" fkcolumn="fk_articleID" elementColumn="OGValue" elementtype="string";

	property name="tags" singularname="tag" cfc="tag" fieldtype="many-to-many" type="array" linktable="article_tags" fkColumn="fk_articleID" inversejoincolumn="fk_tagID" cascade="all";

	public function init() {
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"title")) { VARIABLES["title"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"summary")) { VARIABLES["summary"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"body")) { VARIABLES["body"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"markdown")) { VARIABLES["markdown"] = javaCast("null",""); }

		if (!structKeyExists(VARIABLES,"publicationDate")) { VARIABLES["publicationDate"] = now(); }

		if (!structKeyExists(VARIABLES,"uriStrings")) { VARIABLES["uriStrings"] = []; }
		if (!structKeyExists(VARIABLES,"tags")) { VARIABLES["tags"] = []; }
	}


	public string function getEncodedTitle() {
		return urlEncodeValue(VARIABLES.title);
	}


	public string function getURI() {
		if (arrayLen(VARIABLES["uriStrings"]) == 0) {
			return "";
		} else {
			return VARIABLES["uriStrings"][arrayLen(VARIABLES["uriStrings"])];
		}
	}


	public string function getTagNamesAsList() {
		var _tagList = "";
		for (var _tag in this.getTags()) {
			_tagList = listAppend(_tagList,_tag.getName());
		}
		return _tagList;
	}


	public void function preInsert() hint="call before this being inserted" {
		arrayAppend(VARIABLES.uriStrings,"#year(VARIABLES.publicationDate)#/#dateFormat(VARIABLES.publicationDate,"mm")#/#dateFormat(VARIABLES.publicationDate,"dd")#/#this.getEncodedTitle()#");
	}
	public void function preUpdate(Struct oldData) hint="call before this being updated" {
		super.preUpdate(ARGUMENTS.oldData);

		if (
			(VARIABLES.publicationDate != ARGUMENTS.oldData.publicationDate) ||
			(VARIABLES.title != ARGUMENTS.oldData.title)
		) {
			arrayAppend(VARIABLES.uriStrings,"#year(VARIABLES.publicationDate)#/#dateFormat(VARIABLES.publicationDate,"mm")#/#dateFormat(VARIABLES.publicationDate,"dd")#/#this.getEncodedTitle()#");
		}
	}

	public boolean function isMarkDownArticle() {
		if ((len(this.getMarkDown()) == 0) && (len(this.getBody()) == 0)) {
			return true;
		} else if ((len(this.getMarkDown()) > 0) && (len(this.getBody()) > 0)) {
			return true;
		}
		return false;
	} // close isMarkDownArticle
}
