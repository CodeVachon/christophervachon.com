/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/main.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	}


	public void function default( required struct rc ) {
	}
}