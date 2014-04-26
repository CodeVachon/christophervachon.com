<cfoutput>
	<h2>#APPLICATION.websiteSettings.getSiteName()#</h2>
	<h3>Social Media Feed</h3>
</cfoutput>

<cfscript>
	
	LOCAL.feed = {};

	for (RC.article IN RC.articles) {
		LOCAL.feed[  RC.article.getPublicationDate().getTime()  ] = "<p class='title'>Blog Post</p>" & view("blog/summary");
	}

	for (RC.post in APPLICATION.socialMedia.getTwitterUserFeed()) {
		LOCAL.dateTime = APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_at);
		LOCAL.feed[  LOCAL.dateTime.getTime() + 1 ] = "<p class='title'>Twitter Post</p>" & view("main/socialMedia/twitter/post");
	}

	for (RC.post in APPLICATION.socialMedia.getFacebookPostsForObject()) {
		LOCAL.dateTime = APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_time);
		LOCAL.feed[  LOCAL.dateTime.getTime() + 2 ] = "<p class='title'>Facebook Post</p>" & view("main/socialMedia/facebook/post");
	}

	LOCAL.keys = StructKeyArray(LOCAL.feed);
	ArraySort(LOCAL.keys,"numeric","DESC");
	//writeDump(LOCAL.keys);

	for (LOCAL.i=1;LOCAL.i<=10;LOCAL.i++) {
		writeOutput(  "<div class='social-media-item'>" & LOCAL.feed[LOCAL.keys[LOCAL.i]] & "</div>"  );
	}
	
</cfscript>
