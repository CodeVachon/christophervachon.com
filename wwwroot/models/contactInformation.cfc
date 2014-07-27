/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/contactInformation.cfc
* @author  
* @description
*
*/

component output="false" displayname="contactInformation" extends="ormbase" persistent="true" table="contactInfo" discriminatorColumn="type" {

	property name="isActive" type="boolean" ormtype='boolean';


	public function init() {
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"isActive")) { VARIABLES["isActive"] = true; }
	}


	public models.person function getPerson() {
		return ORMExecuteQuery("SELECT DISTINCT p FROM person p JOIN p.contactInformation c WHERE c.id=:id",{id=this.getID()},true);
	}
}