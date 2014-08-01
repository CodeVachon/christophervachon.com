/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/emailAddress.cfc
* @author  
* @description
*
*/

component output="false" displayname="emailAddress" extends="contactInformation" persistent="true" table="emailAddresses" joinColumn="contactInfoId" discriminatorValue="emailAddress" {

	property name="emailAddress" type="string";


	public function init() {
		return super.init();
	}


	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"emailAddress")) { VARIABLES["emailAddress"] = ""; }
	}
}