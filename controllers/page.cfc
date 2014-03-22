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
		RC.template.addPageCrumb("Pages","/page");
	} // close before


	public void function default( required struct rc ) {
		VARIABLES.fw.service( 'contentService.getContents', 'contentPages' );
	} // default


	public void function view( required struct rc ) {
		var contentService = new services.contentService();
		RC.content = contentService.getContent(RC);
		if (RC.content.getName() == "") {
			writeDump(RC); abort;
			VARIABLES.fw.setView("main.404");
		} else {
			RC.template.addPageCrumb(RC.content.getName(),"/page/" & RC.content.getNameURI());
			RC.pageName = RC.content.getName();
		}
	} // close view
}
