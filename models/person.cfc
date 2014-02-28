/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/person.cfc
* @author  
* @description
*
*/

component output="false" displayname="person" extends="ormbase" persistent="true" table="people" {


	property name="firstName" type="string";
	property name="lastName" type="string";
	property name="password" type="string" sqltype="varchar(1000)" setter="false";


	public function init(){
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"firstName")) { VARIABLES["firstName"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"lastName")) { VARIABLES["lastName"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"password")) { VARIABLES["password"] = javaCast("null",""); }
	}


	public string function getName() {
		return this.getFirstName() & " " & this.getLastName();
	}


	public void function setPassword(required string value) {
		VARIABLES.password = hash(ARGUMENTS.value,"md5");
	}
}