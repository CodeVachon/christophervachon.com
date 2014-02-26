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
	VARIABLES.files = {};

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


	public void function addFile(required string file) {
		var _ext = trim(ListLast(ARGUMENTS.file,"."));
		if (arrayFind(["css","js","ico","png"],_ext)) {
			if (find("/",ARGUMENTS.file) > 0) {
				addFileToArray(_ext,trim(ARGUMENTS.file));
			} else {
				addFileToArray(_ext,"/includes/" & _ext & "/" & trim(ARGUMENTS.file));
			}
		} else {
			throw("unknown file type [#_ext#]");
		}
	}


	public array function getFiles(string key = "") {
		if (len(ARGUMENTS.key) == 0) {
			var _returnArray = [];
			for (var _key in VARIABLES.files) {
				for (var _file in VARIABLES.files[_key]) {
					arrayAppend(_returnArray, _file);
				}
			}
			return _returnArray;
		} else if (structKeyExists(VARIABLES.files,ARGUMENTS.key)) {
			return VARIABLES.files[ARGUMENTS.key];
		} else {
			throw("no files exists for key [#ARGUMENTS.key#]");
		}
	}


	private void function addFileToArray(required string arrayName, required string filepath) {
		if (!structKeyExists(VARIABLES.files, ARGUMENTS.arrayName)) { VARIABLES.files[ARGUMENTS.arrayName] = []; }
		arrayAppend(VARIABLES.files[ARGUMENTS.arrayName],ARGUMENTS.filepath);
	}
}