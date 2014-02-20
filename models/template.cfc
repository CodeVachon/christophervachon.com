/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/template.cfc
* @author  Christopher Vachon
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
			if (ARGUMENTS.index <= arrayLen(VARIABLES.pageCrumb)) {
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


	public string function getSiteTitle(string delimiter = "|") {
		var _title = "";

		for (var i = this.getPageCrumbCount(); i > 0; i--) {
			_title &= this.getPageCrumb(i).label & " #ARGUMENTS.delimiter# ";
		}

		return _title & this.getSiteName();
	}
}