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
	property name="contactInformation" type="array" fieldtype="one-to-many" cfc="contactInformation" fkcolumn="personID" cascade="all";


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


	public boolean function hasEmailAddress() {
		if (structCount(ARGUMENTS) == 1) {
			var _emailAddress = ARGUMENTS[1];
			var validate = new services.validationService();
			if (validate.doesEmailValidate(_emailAddress)) {
				for (var _info in this.getContactInformation()) {
					if ((_info.getType() == "emailAddress") && (_info.getEmailAddress() == _emailAddress)) { return true; }
				}
			} else {
				throw("invalid Email Address [#_emailAddress#]");
			}
		} else {
			for (var _info in this.getContactInformation()) {
				if (_info.getType() == "emailAddress") { return true; }
			}
			return false;
		}
	}


	public void function setPassword(required string value) {
		VARIABLES.password = hash(ARGUMENTS.value,"md5");
	}
}