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
		if (structKeyExists(RC,"year")) { 
			RC.template.addPageCrumb(RC.year,"/blog/#RC.year#"); 
		}
		if (structKeyExists(RC,"month")) { 
			RC.template.addPageCrumb(monthAsString(RC.month),"/blog/#RC.year#/#RC.month#"); 
		}

		if (structKeyExists(RC,"year")) {
			if (structKeyExists(RC,"month")) {
				if (structKeyExists(RC,"day")) {
					RC.startDateRange = createDate(RC.year,RC.month,RC.day);
					RC.endDateRange = createDate(RC.year,RC.month,RC.day);
				} else {
					RC.startDateRange = createDate(RC.year,RC.month,1);
					RC.endDateRange = createDate(RC.year,RC.month,daysInMonth(RC.startDateRange));
				}
			} else {
				RC.startDateRange = createDate(RC.year,1,1);
				RC.endDateRange = createDate(RC.year,12,31);
			}
		} else {
			RC.startDateRange = createDate(year(now())-5,1,1);
			RC.endDateRange = createDate(year(now()),12,31);
		}

		if (RC.endDateRange > now()) { RC.endDateRange = now(); }

		VARIABLES.fw.service( 'articleService.getArticles', 'articles');
	}


	public void function startView( required struct rc ) {
		VARIABLES.fw.service( 'articleService.getArticle', 'article');
	}
	public void function view( required struct rc ) {
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
	}
}