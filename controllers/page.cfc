/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/controllers/page.cfc
* @author  
* @description
*
*/

component output="false" displayname="page"  {
	public any function init( fw ) {
		VARIABLES.fw = fw;
		return this;
	} //  close init


	public void function before( required struct rc ) {
		RC.template.addPageCrumb("Page","/page");
	} // close before


	public void function default( required struct rc ) {
	} // default


	public void function view( required struct rc ) {
		var contentService = new services.contentService();
		RC.content = contentService.getContent(RC);
		if (RC.content.getName() == "") {
			VARIABLES.fw.setView("main.404");
		} else {
			RC.template.addPageCrumb(RC.content.getName(),"/page/" & RC.content.getName());
			RC.pageName = RC.content.getName();
		}
	} // close view
}
