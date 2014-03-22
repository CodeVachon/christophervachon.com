/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/contentService.cfc
* @author  
* @description
*
*/

component output="false" displayname="contentService" extends="base" {

	public function init() { return this; }


	public array function getContents() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		if (!structKeyExists(ARGUMENTS,"page")) { ARGUMENTS.page = 1; }
		if (!structKeyExists(ARGUMENTS,"itemsPerPage")) { ARGUMENTS.itemsPerPage = 25; }
		if (!structKeyExists(ARGUMENTS,"orderBy")) { ARGUMENTS.orderBy = "name ASC"; }
		if (!structKeyExists(ARGUMENTS,"isDeleted")) { ARGUMENTS.isDeleted = false; }

		var _maxResults = int(ARGUMENTS.itemsPerPage);
		var _offset=((ARGUMENTS.page-1)*_maxResults);

		var qryParts = {
			join = "",
			clause = "",
			args = {
				isDeleted=ARGUMENTS.isDeleted
			}
		};

		return ORMExecuteQuery("
			SELECT DISTINCT c 
			FROM content c 
			#qryParts.join#
			WHERE c.isDeleted=:isDeleted
			#qryParts.clause#
			ORDER BY c.#ARGUMENTS.orderBy#
		", 
		qryParts.args, 
		false, 
		{
			maxResults=_maxResults,
			offset=_offset
		});
	}


	public any function getContent() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var _object = javaCast("null","");
		if (structKeyExists(ARGUMENTS,"contentId")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM content o WHERE o.id=:id",{id=ARGUMENTS["contentId"]},true); }
		if (structKeyExists(ARGUMENTS,"name")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM content o WHERE o.name=:name",{name=ARGUMENTS["name"]},true); }
		else if (structKeyExists(ARGUMENTS,"id")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM content o WHERE o.id=:id",{id=ARGUMENTS["id"]},true); }

		if (isNull(_object)) { _object = entityNew("content"); }

		return _object;
	} // close getContent


	public models.content function editContent() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		var _content = this.setValuesInObject(this.getContent(ARGUMENTS),ARGUMENTS);
		return _content;
	} // close editContent


	public models.content function editContentAndSave() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.saveObject(this.editContent(ARGUMENTS));
	} // close editContent
}
