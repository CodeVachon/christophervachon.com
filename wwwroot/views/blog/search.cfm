<cfscript>
	param name="RC.search_for" default="";
	LOCAL.articleService = new services.articleService();
</cfscript>
<cfoutput>
	<h1>Search<cfif len(RC.search_for) GT 0>: #RC.search_for#</cfif></h1>
	<cfif len(RC.search_for) GT 0>
		<cfif RC.searchResults.recordCount GT 0>
			<section class='article-list'>
				<cfloop query="RC.searchResults">
					<cfscript>
						RC.article = LOCAL.articleService.getArticle(articleId=RC.searchResults.key);
						writeOutput(view("blog/summary"));
					</cfscript>
				</cfloop>
			</section>
		<cfelse>
			<div class='alert alert-warning'>
				<p>Sorry, no results were found using your search term.</p>
			</div>
		</cfif>
		<div class='divider'></div>
	</cfif>

	<form name="/blog/search" method="get" />
		<div>
			<label for="search_for">Search For:</label>
			<input type="text" name="search_for" value="#RC.search_for#" />
		</div>
		<div>
			<input type="submit" value="Fetch" class='btn btn-primary' />
		</div>
	</form>
</cfoutput>
