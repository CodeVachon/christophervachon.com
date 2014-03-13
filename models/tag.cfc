/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/tag.cfc
* @author  
* @description
*
*/

component output="false" displayname="tag" extends="ormbase" persistent="true" table="tags"  {

	property name="name" type="string" unique=true;
	property name="articleCount" formula="SELECT COUNT(a.fk_articleID) FROM article_tags a WHERE a.fk_tagID=id" setter=false;

	public function init(){
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"name")) { VARIABLES["name"] = javaCast("null",""); }
	}
}