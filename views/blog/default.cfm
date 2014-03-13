<cfparam name="RC.tags" default="" />
<cfoutput>
	<h2><cfif structKeyExists(RC,"month") && isNumeric(RC.month)>#monthAsString(int(RC.month))# </cfif><cfif structKeyExists(RC,"year")>#RC.year# </cfif>Blog Entries<cfif listLen(RC.tags) GT 0> - Tags: #RC.tags#</cfif><cfif RC.page GT 1>: Page #RC.page#</cfif></h2>
	<cfif arrayLen(RC.articles) GT 0>
		<cfloop array="#RC.articles#" index="RC.article">
			#view("blog/summary")#
		</cfloop>

		<cfscript>
			LOCAL.pageCount = ceiling(RC.articleCount/RC.itemsPerPage);
		</cfscript>

		<cfif LOCAL.pageCount GT 1>
			<ul class="pagination">
				<li#((RC.page LTE 1)?" class='disabled'":"")#><a href="#CGI.PATH_INFO#?page=#((RC.page LTE 1)?1:RC.page-1)#">&laquo;</a></li>
				<cfloop from="1" to="#LOCAL.pageCount#" index="LOCAL.pageNo">
					<li#((LOCAL.pageNo EQ RC.page)?" class='active'":"")#><a href="#CGI.PATH_INFO#?page=#LOCAL.pageNo#">#LOCAL.pageNo#</a></li>
				</cfloop>
				<li#((RC.page GTE LOCAL.pageCount)?" class='disabled'":"")#><a href="#CGI.PATH_INFO#?page=#((RC.page GTE LOCAL.pageCount)?LOCAL.pageCount:RC.page+1)#">&raquo;</a></li>
			</ul>
		</cfif>
	<cfelse>
		<p>Sorry, No Blogs Posts have been found in this criteia.</p>
	</cfif>
</cfoutput>