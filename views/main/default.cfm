<cfoutput>
	<h2>#APPLICATION.websiteSettings.getSiteName()#</h2>


<cfscript>
	for (RC.post in APPLICATION.socialMedia.getTwitterUserFeed()) {
		writeOutput("<p class='title'>Twitter Post</p>");
		writeOutput(view("main/socialMedia/twitter/post"));
	}
</cfscript>



	<cfif arrayLen(RC.articles) GT 0>
		<cfloop array="#RC.articles#" index="RC.article">
			#view("blog/summary")#
		</cfloop>
	</cfif>
</cfoutput>