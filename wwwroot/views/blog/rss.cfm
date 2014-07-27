<cfscript>
	REQUEST.layout = false;

	LOCAL.serverURL = "http://#CGI.SERVER_NAME#/";

	LOCAL.rssFeed = {};
	LOCAL.rssFeed.link = LOCAL.serverURL;
	LOCAL.rssFeed.title = "My Site";
	LOCAL.rssFeed.description = "My Site Blogs";
	LOCAL.rssFeed.pubDate = now();
	LOCAL.rssFeed.version = "rss_2.0"; 

	LOCAL.rssFeed.item = [];
	LOCAL.articleCount = arrayLen(RC.articles);
	if (LOCAL.articleCount > 15) { LOCAL.articleCount = 15; }
	for (LOCAL.i=1;LOCAL.i<=LOCAL.articleCount;LOCAL.i++) {
		writeDump(var=RC.articles[LOCAL.i]);
		LOCAL.thisArticle = {};

		LOCAL.thisArticle.title = RC.articles[LOCAL.i].getTitle();
		LOCAL.thisArticle.link = LOCAL.serverURL & "blog/" & RC.articles[LOCAL.i].getURI();
		LOCAL.thisArticle.description = {};
		LOCAL.thisArticle.description.value = RC.articles[LOCAL.i].getsummary();
		LOCAL.thisArticle.pubDate = RC.articles[LOCAL.i].getPublicationDateAsCFDateTime();
		LOCAL.thisArticle.category = [];
		for (LOCAL.tag in RC.articles[LOCAL.i].getTags()) {
			LOCAL.categoryTag = {};
			LOCAL.categoryTag.value = LOCAL.tag.getName();
			arrayAppend(LOCAL.thisArticle.category,LOCAL.categoryTag);
		}

		arrayAppend(LOCAL.rssFeed.item, LOCAL.thisArticle);
	}



</cfscript>
<cffeed action = "create" name = "#LOCAL.rssFeed#" escapechars="false" xmlVar="LOCAL.myXML" /> 
<cfcontent reset="true" type="text/plain"/><cfoutput>#LOCAL.myXML#</cfoutput>