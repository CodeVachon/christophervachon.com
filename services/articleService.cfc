/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/articleService.cfc
* @author  
* @description
*
*/

component output="false" displayname="articleService" extends="base"  {

	public function init() { return this; }


	public array function getArticles() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		if (!structKeyExists(ARGUMENTS,"page")) { ARGUMENTS.page = 1; }
		if (!structKeyExists(ARGUMENTS,"itemsPerPage")) { ARGUMENTS.itemsPerPage = 25; }
		if (!structKeyExists(ARGUMENTS,"orderBy")) { ARGUMENTS.orderBy = "publicationDate DESC"; }
		if (!structKeyExists(ARGUMENTS,"isDeleted")) { ARGUMENTS.isDeleted = false; }

		var _maxResults = int(ARGUMENTS.itemsPerPage);
		var _offset=((ARGUMENTS.page-1)*_maxResults);

		return ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.isDeleted=:isDeleted ORDER BY a.#ARGUMENTS.orderBy#", {isDeleted=ARGUMENTS.isDeleted}, false, {maxResults=_maxResults,offset=_offset});
	} // close getArticles


	public models.article function getArticle() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var _object = javaCast("null","");
		if (structKeyExists(ARGUMENTS,"articleId")) { _object = ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.id=:id",{id=ARGUMENTS["articleId"]},true); }
		else if (structKeyExists(ARGUMENTS,"id")) { _object = ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.id=:id",{id=ARGUMENTS["id"]},true); }

		if (isNull(_object)) { _object = entityNew("article"); }

		return _object;
	} // close getArticle


	public models.article function editArticle() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.setValuesInObject(this.getArticle(ARGUMENTS),ARGUMENTS);
	} // close editArticle


	public models.article function editArticleAndSave() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.saveObject(this.editArticle(ARGUMENTS));
	} // close editArticle
}
