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
	property name="nameURI" type="string" setter=false;


	public function init() { return super.init(); }


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"name")) { VARIABLES["name"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"body")) { VARIABLES["body"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"nameURI")) { VARIABLES["nameURI"] = javaCast("null",""); }
	} // close refreshProperties


	public string function getNameURI() {
		return urlEncodeValue(lcase(this.getName()));
	} // close getNameURI


	public void function preInsert() hint="call before this being inserted" {
		VARIABLES.nameURI = this.getNameURI();
	}
	public void function preUpdate(Struct oldData) hint="call before this being updated" {
		VARIABLES.nameURI = this.getNameURI();
	}
}
