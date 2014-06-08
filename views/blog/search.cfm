<cfscript>
	param name="RC.search_for" default="";
	LOCAL.articleService = new services.articleService();
</cfscript>
<cfoutput>
	<h1>Search: #RC.search_for#</h1>
	<cfif RC.searchResults.recordCount GT 0>
		<cfloop query="RC.searchResults">
			<cfscript>
				RC.article = LOCAL.articleService.getArticle(articleId=RC.searchResults.key);
				writeOutput(view("blog/summary"));
			</cfscript>
		</cfloop>
	<cfelse>
		<div class='alert alert-warning'>
			<p>Sorry, no results were found using your search term.</p>
		</div>
	</cfif>
</cfoutput>
