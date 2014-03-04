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