/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/template.cfc
* @author  
* @description
*
*/

component output="false" displayname="template" extends="base" {

	VARIABLES.siteName = "";
	VARIABLES.pageCrumb = [];

	public template function init(){
		return super.init(ARGUMENTS);
	}


	public void function setSiteName(required string siteName) {
		VARIABLES.siteName = trim(ARGUMENTS.siteName);
	}


	public string function getSiteName() {
		return VARIABLES.siteName;
	}


	public void function addPageCrumb(required string pageTitle, string pageURL) {
		arrayAppend(VARIABLES.pageCrumb, {label=trim(ARGUMENTS.pageTitle),url=trim(ARGUMENTS.pageURL)});
	}


	public struct function getPageCrumb(required numeric index) {
		ARGUMENTS.index = int(ARGUMENTS.index);
		if (ARGUMENTS.index > 0) {
			if (arrayLen(VARIABLES.pageCrumb) <= ARGUMENTS.index) {
				return VARIABLES.pageCrumb[ARGUMENTS.index];
			} else {
				throw("No Value Exists at Index [#ARGUMENTS.index#]");
			}
		} else {
			throw("Invalid value passed [#ARGUMENTS.index#] - Expected Integer Greater then 0");
		}
	}


	public numeric function getPageCrumbCount() {
		return arrayLen(VARIABLES.pageCrumb);
	}
}