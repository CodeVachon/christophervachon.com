/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/base.cfc
* @author  
* @description
*
*/

component output="false" displayname="base"  {


	public base function init(){
		return this;
	}


	public string function getClassName() hint="return the name of this object" { return ListLast(GetMetaData(this).fullname,"."); }


	private string function urlEncodeValue(required string value) {
		return lCase(reReplace(reReplace(trim(ARGUMENTS.value),"\W{1,}","-","all"),"-{1,}$","","one"));
	}
}