<cfscript>
	LOCAL.articleService = new services.articleService();
</cfscript>
<cfoutput>
	<h2>Search: #RC.search_for#</h2>
	<cfloop query="RC.searchResults">
		<cfscript>
			RC.article = LOCAL.articleService.getArticle(articleId=RC.searchResults.key);
			writeOutput(view("blog/summary"));
		</cfscript>
	</cfloop>
</cfoutput>
