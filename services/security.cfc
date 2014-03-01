/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/security.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {

	public function init() { return this; }


	public boolean function checkPermission() {
		return false;
	}
}