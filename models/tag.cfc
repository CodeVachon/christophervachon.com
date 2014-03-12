/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/tag.cfc
* @author  
* @description
*
*/

component output="false" displayname="tag" extends="ormbase" persistent="true" table="tags"  {

	property name="name" type="string" unique=true;

	public function init(){
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"name")) { VARIABLES["name"] = javaCast("null",""); }
	}
}