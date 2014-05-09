<cfoutput>
	<h2>#APPLICATION.websiteSettings.getSiteName()#</h2>
	<h3>Social Media Feed</h3>
</cfoutput>

<cfscript>
	
	LOCAL.feed = {};

	try {
		for (RC.article IN RC.articles) {
			LOCAL.feed[  RC.article.getPublicationDate().getTime()  ] = "<p class='title'>Blog Post</p>" & view("blog/summary");
		}
	} catch (any e) {}
	try {
		for (RC.post in APPLICATION.socialMedia.getTwitterUserFeed()) {
			LOCAL.dateTime = APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_at);
			LOCAL.feed[  LOCAL.dateTime.getTime() + 1 ] = "<p class='title'>Twitter Post</p>" & view("main/socialMedia/twitter/post");
		}
	} catch (any e) {}
	try {
		for (RC.post in APPLICATION.socialMedia.getFacebookPostsForObject()) {
			LOCAL.dateTime = APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_time);
			LOCAL.feed[  LOCAL.dateTime.getTime() + 2 ] = "<p class='title'>Facebook Post</p>" & view("main/socialMedia/facebook/post");
		}
	} catch (any e) {}
	LOCAL.keys = StructKeyArray(LOCAL.feed);
	ArraySort(LOCAL.keys,"numeric","DESC");
	//writeDump(LOCAL.keys);

	LOCAL.itemLimit = 10;
	if (structCount(LOCAL.feed) < LOCAL.itemLimit) { LOCAL.itemLimit = structCount(LOCAL.feed); }

	for (LOCAL.i=1;LOCAL.i<=LOCAL.itemLimit;LOCAL.i++) {
		writeOutput(  "<div class='social-media-item'>" & LOCAL.feed[LOCAL.keys[LOCAL.i]] & "</div>"  );
	}
	
</cfscript>