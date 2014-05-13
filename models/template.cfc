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
	VARIABLES.metaTags = {};

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


	public void function addMetaTag() {
		if ((!structKeyExists(ARGUMENTS,"name")) && (!structKeyExists(ARGUMENTS,"property"))) { throw("META tag requires a NAME and/or PROPERTY"); }
		var _metaData = structNew();
		var _key = "";
		if (structKeyExists(ARGUMENTS,"name")) { _metaData["name"] = trim(ARGUMENTS.name); _key = trim(ARGUMENTS.name); }
		if (structKeyExists(ARGUMENTS,"property")) { _metaData["property"] = trim(ARGUMENTS.property); _key = trim(ARGUMENTS.property); }
		if (structKeyExists(ARGUMENTS,"content")) { _metaData["content"] = trim(ARGUMENTS.content); }
		if (structKeyExists(ARGUMENTS,"href")) { _metaData["href"] = trim(ARGUMENTS.href); }

		VARIABLES.metaTags[_key] = _metaData;
	}


	public array function getMetaTags() {
		var _tags = [];
		for (var _key in VARIABLES.metaTags) {
			arrayAppend(_tags,VARIABLES.metaTags[_key]);
		}
		return _tags;
	}


	private void function addFileToArray(required string arrayName, required string filepath) {
		if (!structKeyExists(VARIABLES.files, ARGUMENTS.arrayName)) { VARIABLES.files[ARGUMENTS.arrayName] = []; }
		arrayAppend(VARIABLES.files[ARGUMENTS.arrayName],ARGUMENTS.filepath);
	}


	public void function clearFiles(string type = "") {
		if (structKeyExists(VARIABLES.files,ARGUMENTS.type)) {
			VARIABLES.files[ARGUMENTS.type] = [];
		}
	}
}