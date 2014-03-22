/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/content.cfc
* @author  
* @description
*
*/

component output="false" displayname="content" extends="ormbase" persistent="true" table="content" {


	property name="name" type="string";
	property name="body" type="string" length="50000";


	public function init() { return super.init(); }


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"name")) { VARIABLES["name"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"body")) { VARIABLES["body"] = javaCast("null",""); }
	} // close refreshProperties
}
