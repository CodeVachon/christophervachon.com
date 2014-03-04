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
	property name="publicationDate" type="datetime" ormtype="timestamp";

	property name="uriStrings" setter="false" fieldtype="collection" type="array" table="articles_uris" fkcolumn="fk_articleID" elementColumn="OGValue" elementtype="string";


	public function init() {
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"title")) { VARIABLES["title"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"summary")) { VARIABLES["summary"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"body")) { VARIABLES["body"] = javaCast("null",""); }

		if (!structKeyExists(VARIABLES,"publicationDate")) { VARIABLES["publicationDate"] = now(); }

		if (!structKeyExists(VARIABLES,"uriStrings")) { VARIABLES["uriStrings"] = []; }
	}


	public void function preInsert() hint="call before this being inserted" {
		arrayAppend(VARIABLES.uriStrings,"#year(VARIABLES.publicationDate)#/#month(VARIABLES.publicationDate)#/#urlEncodeValue(VARIABLES.title)#");
	}
	public void function preUpdate(Struct oldData) hint="call before this being updated" {
		super.preUpdate(ARGUMENTS.oldData);

		if (
			(VARIABLES.publicationDate != ARGUMENTS.oldData.publicationDate) ||
			(VARIABLES.title != ARGUMENTS.oldData.title)
		) {
			arrayAppend(VARIABLES.uriStrings,"#year(VARIABLES.publicationDate)#/#month(VARIABLES.publicationDate)#/#urlEncodeValue(VARIABLES.title)#");
		}
	}
}
