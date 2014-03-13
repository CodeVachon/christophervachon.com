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
		if (!structKeyExists(ARGUMENTS,"notBeforeDate")) { ARGUMENTS.notBeforeDate = now(); }
		if (!structKeyExists(ARGUMENTS,"tags")) { ARGUMENTS.tags = ""; }
		if (!structKeyExists(ARGUMENTS,"notArticleID")) { ARGUMENTS.notArticleID = ""; }

		var _maxResults = int(ARGUMENTS.itemsPerPage);
		var _offset=((ARGUMENTS.page-1)*_maxResults);

		var qryParts = {
			join = "",
			clause = "",
			args = {
				isDeleted=ARGUMENTS.isDeleted
			}
		};

		if (listLen(ARGUMENTS.tags) > 0) {
			qryParts.join &= "JOIN a.tags t ";
			qryParts.clause &= "AND t.name IN (:tags) ";
			qryParts.args.tags = listToArray(ARGUMENTS.tags);
		}
		if (listLen(ARGUMENTS.notArticleID) > 0) {
			qryParts.clause &= "AND a.id NOT IN (:notArticleID) ";
			qryParts.args.notArticleID = listToArray(ARGUMENTS.notArticleID);
		}
		if (structKeyExists(ARGUMENTS,"startDateRange") && structKeyExists(ARGUMENTS,"endDateRange")) {
			qryParts.clause &= "AND a.publicationDate >= :startDateRange AND a.publicationDate <= :endDateRange ";
			qryParts.args.startDateRange=dateFormat(ARGUMENTS.startDateRange,"yyyy-mm-dd 00:00:00.0000");
			qryParts.args.endDateRange=dateFormat(ARGUMENTS.endDateRange,"yyyy-mm-dd 23:59:59.9999");
		} else {
			qryParts.clause &= "a.publicationDate <= :notBeforeDate ";
			qryParts.args.notBeforeDate = ARGUMENTS.notBeforeDate;
		}

		return ORMExecuteQuery("
			SELECT DISTINCT a 
			FROM article a 
			#qryParts.join#
			WHERE a.isDeleted=:isDeleted
			#qryParts.clause#
			ORDER BY a.#ARGUMENTS.orderBy#
		", 
		qryParts.args, 
		false, 
		{
			maxResults=_maxResults,
			offset=_offset
		});
	} // close getArticles


	public models.article function getArticle() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var _object = javaCast("null","");
		if (structKeyExists(ARGUMENTS,"articleId")) { _object = ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.id=:id",{id=ARGUMENTS["articleId"]},true); }
		else if (structKeyExists(ARGUMENTS,"articleDate")) {
			var _uriString = "#listGetAt(ARGUMENTS.articleDate,1,"-")#/#listGetAt(ARGUMENTS.articleDate,2,"-")#/#listGetAt(ARGUMENTS.articleDate,3,"-")#/#ARGUMENTS.title#";
			var _articles = ORMExecuteQuery("SELECT DISTINCT a FROM article a JOIN a.uriStrings s WHERE s=:uriString",{uriString=_uriString},false);
			if (arrayLen(_articles) == 0) {
				_articles = ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.publicationDate=:articleDate",{articleDate=createDate(listGetAt(ARGUMENTS.articleDate,1,"-"),listGetAt(ARGUMENTS.articleDate,2,"-"),listGetAt(ARGUMENTS.articleDate,3,"-"))},false);
			}

			for (var _artcile in _articles) {
				if (_artcile.getEncodedTitle() == ARGUMENTS.title) {
					_object = _artcile;
				}
			}
		}
		else if (structKeyExists(ARGUMENTS,"id")) { _object = ORMExecuteQuery("SELECT DISTINCT a FROM article a WHERE a.id=:id",{id=ARGUMENTS["id"]},true); }

		if (isNull(_object)) { _object = entityNew("article"); }

		return _object;
	} // close getArticle


	public models.article function editArticle() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		var _article = this.setValuesInObject(this.getArticle(ARGUMENTS),ARGUMENTS);

		// Set Article Tags
		if (structKeyExists(ARGUMENTS,"articleTags")) {
			_article.getTags().clear();
			for (var _tagName in listToArray(ARGUMENTS.articleTags)) {
				_article.addTag(this.editTag(name=_tagName));
			}
		}

		return _article;
	} // close editArticle


	public models.article function editArticleAndSave() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.saveObject(this.editArticle(ARGUMENTS));
	} // close editArticle


	public numeric function getArticleCountInTimeSpan(required date startDate, required date endDate, string tags = "") {
		if (!structKeyExists(ARGUMENTS,"tags")) { ARGUMENTS.tags = ""; }

		var _startDate = createDateTime(year(ARGUMENTS.startDate),month(ARGUMENTS.startDate),day(ARGUMENTS.startDate),0,0,0);
		var _endDate = createDateTime(year(ARGUMENTS.endDate),month(ARGUMENTS.endDate),day(ARGUMENTS.endDate),23,59,59);

		if (listLen(ARGUMENTS.tags) > 0) {
			return ORMExecuteQuery("SELECT DISTINCT count(a.id) FROM article a JOIN a.tags t WHERE t.name in (:tags) AND a.publicationDate BETWEEN :startDate AND :endDate AND a.isDeleted=false",{tags=listToArray(ARGUMENTS.tags),startDate=_startDate,endDate=_endDate},true);
		} else {
			return ORMExecuteQuery("SELECT DISTINCT count(a.id) FROM article a WHERE a.publicationDate BETWEEN :startDate AND :endDate AND a.isDeleted=false",{startDate=_startDate,endDate=_endDate},true);
		}
	} // close getArticleCountInTimeSpan


	public array function getArticlePublishedBookMarks() {
		var _bookmarks = [];
		var _datesMinAndMAx = ORMExecuteQuery("SELECT DISTINCT min(a.publicationDate) AS minDate, max(a.publicationDate) AS maxDate FROM article a WHERE a.isDeleted=false",{},true);
		var _startDate = _datesMinAndMAx[1];
		var _endDate = _datesMinAndMAx[2];

		for (var _year = year(_endDate); _year >= year(_startDate); _year--) {
			var _months = [];
			var _thisYearStart = createDate(_year,1,1);
			var _thisYearEnd = createDate(_year,12,31);

			if (_thisYearStart < _startDate) { _thisYearStart = _startDate; }
			if (_thisYearEnd > _endDate) { _thisYearEnd = _endDate; }

			for (var _month = month(_thisYearEnd); _month >= month(_thisYearStart); _month--) {
				var _monthStart = createDate(_year, _month, 1);
				var _monthEnd = createDate(_year, _month, daysInMonth(_monthStart));
				if (_monthEnd > now()) { _monthEnd = now(); }

				var _articleCount = this.getArticleCountInTimeSpan(_monthStart,_monthEnd);
				arrayAppend(_months,{month = dateFormat(_monthStart,"mmmm"), articleCount = _articleCount, date=_monthStart});
			}

			if (_thisYearEnd > now()) { _thisYearEnd = now(); }
			var _articleCount = this.getArticleCountInTimeSpan(_thisYearStart,_thisYearEnd);
			arrayAppend(_bookmarks,{year=_year,months=_months,articleCount = _articleCount,date=_thisYearStart});
		}

		return _bookmarks;
	} // close getArticlePublishedBookMarks


/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* -=- Tags =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
	public array function getTags() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		if (!structKeyExists(ARGUMENTS,"page")) { ARGUMENTS.page = 1; }
		if (!structKeyExists(ARGUMENTS,"itemsPerPage")) { ARGUMENTS.itemsPerPage = 25; }
		if (!structKeyExists(ARGUMENTS,"orderBy")) { ARGUMENTS.orderBy = "name ASC"; }
		if (!structKeyExists(ARGUMENTS,"isDeleted")) { ARGUMENTS.isDeleted = false; }

		var _maxResults = int(ARGUMENTS.itemsPerPage);
		var _offset=((ARGUMENTS.page-1)*_maxResults);

		return ORMExecuteQuery("SELECT DISTINCT t FROM tag t WHERE t.isDeleted=:isDeleted ORDER BY t.#ARGUMENTS.orderBy#", {isDeleted=ARGUMENTS.isDeleted}, false, {maxResults=_maxResults,offset=_offset});
	} // close getTags


	public models.tag function getTag() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }

		var _object = javaCast("null","");
		if (structKeyExists(ARGUMENTS,"tagId")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM tag o WHERE o.id=:id",{id=ARGUMENTS["tagId"]},true); }
		else if (structKeyExists(ARGUMENTS,"tagName")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM tag o WHERE o.name=:name",{name=ARGUMENTS["tagName"]},true); }
		else if (structKeyExists(ARGUMENTS,"name")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM tag o WHERE o.name=:name",{name=ARGUMENTS["name"]},true); }
		else if (structKeyExists(ARGUMENTS,"id")) { _object = ORMExecuteQuery("SELECT DISTINCT o FROM tag o WHERE o.id=:id",{id=ARGUMENTS["id"]},true); }

		if (isNull(_object)) { _object = entityNew("tag"); }

		return _object;
	} // close getTag


	public models.tag function editTag() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.setValuesInObject(this.getTag(ARGUMENTS),ARGUMENTS);
	} // close editTag


	public models.tag function editTagAndSave() {
		if ((structCount(ARGUMENTS) == 1) && isStruct(ARGUMENTS[1])) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return this.saveObject(this.editTag(ARGUMENTS));
	} // close editTagAndSave
}
