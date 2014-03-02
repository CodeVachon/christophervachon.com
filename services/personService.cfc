/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/personService.cfc
* @author  
* @description
*
*/

component output="false" displayname="personService" extends="base"  {

	public function init() { return this; }


	public array function getPeople() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		if (!structKeyExists(ARGUMENTS,"page")) { ARGUMENTS.page = 1; }
		if (!structKeyExists(ARGUMENTS,"itemsPerPage")) { ARGUMENTS.itemsPerPage = 25; }
		if (!structKeyExists(ARGUMENTS,"orderBy")) { ARGUMENTS.orderBy = "LastName"; }
		if (!structKeyExists(ARGUMENTS,"isDeleted")) { ARGUMENTS.isDeleted = false; }

		var _maxResults = int(ARGUMENTS.itemsPerPage);
		var _offset=((ARGUMENTS.page-1)*_maxResults);

		return ORMExecuteQuery("SELECT DISTINCT p FROM person p WHERE p.isDeleted=:isDeleted ORDER BY p.#ARGUMENTS.orderBy# ASC", {isDeleted=ARGUMENTS.isDeleted}, false, {maxResults=_maxResults,offset=_offset});
	}


	public boolean function doesPersonExist() {
		var _object = ORMExecuteQuery("FROM person p JOIN p.contactInformation c WHERE c.emailAddress=:emailAddress",{emailAddress=ARGUMENTS["emailAddress"]},true); 

		return ((isNull(_object))?false:true);
	}


	public models.person function getPerson() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var _object = javaCast("null","");
		if (structKeyExists(ARGUMENTS,"personId")) { _object = ORMExecuteQuery("SELECT DISTINCT p FROM person p WHERE p.id=:id",{id=ARGUMENTS["personId"]},true); }
		else if (structKeyExists(ARGUMENTS,"emailAddress")) { _object = ORMExecuteQuery("SELECT DISTINCT p FROM person p JOIN p.contactInformation c WHERE c.emailAddress=:emailAddress",{emailAddress=ARGUMENTS["emailAddress"]},true); }
		else if (structKeyExists(ARGUMENTS,"id")) { _object = ORMExecuteQuery("SELECT DISTINCT p FROM person p WHERE p.id=:id",{id=ARGUMENTS["id"]},true); }

		if (isNull(_object)) { _object = entityNew("person"); }

		return _object;
	} // close getPerson


	public models.person function editPerson() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		var _object = this.setValuesInObject(this.getPerson(ARGUMENTS),ARGUMENTS);

		if (structKeyExists(ARGUMENTS,"emailAddress")) {
			if (!_object.hasEmailAddress(ARGUMENTS.emailAddress)) {
				var _emailAddress = entityNew("emailaddress");
				_emailAddress.setEmailAddress(ARGUMENTS.emailaddress);
				_object.addContactInformation(_emailAddress);
			}
		}

		if (structKeyExists(ARGUMENTS,"password")) {
			_object.setPassword(ARGUMENTS.password);
		}

		return _object;
	}


	public models.person function editPersonAndSave() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.saveObject(this.editPerson(ARGUMENTS));
	}


	public void function removePerson() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		this.removeObject(this.getPerson(ARGUMENTS));
	}
}