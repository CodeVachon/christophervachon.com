/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/blog.cfc
* @author  
* @description
*
*/

component output="false" displayname="blog"  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	} //  close init


	public void function before( required struct rc ) {
		RC.template.addPageCrumb("Blog","/blog");
	} // close before


	public void function default( required struct rc ) {
		RC.itemsPerPage = 10;
		param name="RC.page" default="1";

		var cause404 = false;

		if (structKeyExists(RC,"year")) {
			if (isNumeric(RC.year) && (RC.year <= year(now()))) {
				RC.template.addPageCrumb(RC.year,"/blog/#RC.year#"); 
				if (structKeyExists(RC,"month")) {
					if (isNumeric(RC.month) && ((RC.month >= 1) && (RC.month <= 12))) {
						RC.template.addPageCrumb(monthAsString(RC.month),"/blog/#RC.year#/#RC.month#"); 
						if (structKeyExists(RC,"day")) {
							if (isNumeric(RC.day) && ((RC.day >= 1) && (RC.day <= daysInMonth(createDate(RC.year,RC.month,1))))) {
								RC.startDateRange = createDate(RC.year,RC.month,RC.day);
								RC.endDateRange = createDate(RC.year,RC.month,RC.day);
							} else {
								cause404 = true;
							}
						} else {
							RC.startDateRange = createDate(RC.year,RC.month,1);
							RC.endDateRange = createDate(RC.year,RC.month,daysInMonth(RC.startDateRange));
						}
					} else {
						cause404 = true;
					}
				} else {
					RC.startDateRange = createDate(RC.year,1,1);
					RC.endDateRange = createDate(RC.year,12,31);
				}
			} else {
				cause404 = true;
			}
		} else {
			RC.startDateRange = createDate(year(now())-5,1,1);
			RC.endDateRange = createDate(year(now()),12,31);
		}

		if (structKeyExists(RC,"tags") && (listLen(RC.tags) > 0)) {
			RC.template.addPageCrumb("Tags: #RC.tags#","/blog/tags/#RC.tags#"); 
		}

		if (structKeyExists(RC,"page")) { 
			if (isNumeric(RC.page) && (RC.page >= 1)) {
				RC.page = int(RC.page);
				if (RC.page > 1) {
					RC.template.addPageCrumb("Page #RC.page#",""); 
				}
			} else {
				cause404 = true;
			}
		} else { 
			RC.page = 1; 
		}

		if (cause404) {
			VARIABLES.fw.setView("main.404");
		} else {
			if (RC.endDateRange > now()) { RC.endDateRange = now(); }

			VARIABLES.fw.service( 'articleService.getArticles', 'articles');
			VARIABLES.fw.service( 'articleService.getArticleCountInTimeSpan', 'articleCount', {startDate=RC.startDateRange,endDate=RC.endDateRange});
		}
	} 
	public void function endDefault( required struct rc ) {
		if (structKeyExists(RC,"articleCount")) {
			var pageCount = ceiling(RC.articleCount/RC.itemsPerPage);
			if (RC.page > pageCount) {
				VARIABLES.fw.setView("main.404");
			}
		}
	}// close default


	public void function startView( required struct rc ) {
		var _articleService = new services.articleService();
		RC.article = _articleService.getArticle(RC);
		RC.relatedArticles = _articleService.getArticles(notArticleID=RC.article.getID(),tags=RC.article.getTagNamesAsList(),page=1,itemsPerPage=3);
		//VARIABLES.fw.service( 'articleService.getArticles', 'relatedArticles', {tags=RC.article.getTagNamesAsList(), page=1, itemsPerPage=3});
	}
	public void function view( required struct rc ) {
		RC.template.addMetaTag(name="keywords",content=RC.article.getTagNamesAsList());
		RC.template.addMetaTag(name="description",content=RC.article.getSummary());
		RC.template.addFile("/includes/js/plugin.syntaxhighlighter.js");
	}
	public void function endView( required struct rc ) {
		var _url = replace(CGI.PATH_INFO,"/blog/","","one");
		if (len(RC.article.getURI()) > 0) {
			if (_url != RC.article.getURI()) {
				location(url="/blog/" & RC.article.getURI(),statuscode="301",addtoken=false);
			}

			RC.template.addPageCrumb(dateFormat(RC.article.getPublicationDate(),"yyyy"),"/blog/#dateFormat(RC.article.getPublicationDate(),"yyyy")#");
			RC.template.addPageCrumb(dateFormat(RC.article.getPublicationDate(),"mmmm"),"/blog/#dateFormat(RC.article.getPublicationDate(),"yyyy")#/#dateFormat(RC.article.getPublicationDate(),"mm")#");
			RC.template.addPageCrumb(RC.article.getTitle(),"/blog/#RC.article.getURI()#");
		} else {
			VARIABLES.fw.setView("main.404");
		}
	} // close view


	public void function search( required struct rc ) {
		if (!structKeyExists(RC,"search_for")) { VARIABLES.fw.redirect(action='blog'); }
		RC.template.addPageCrumb("Search: " & RC.search_for,"/blog/search?search_for=#RC.search_for#");

		var searchService = new services.searchService(APPLICATION.blogCollectionName);
		RC.searchResults = searchService.search(RC.search_for);
	} // close search
}
