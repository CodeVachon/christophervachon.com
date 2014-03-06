<cfoutput>
	<h2><cfif structKeyExists(RC,"month")>#monthAsString(RC.month)# </cfif><cfif structKeyExists(RC,"year")>#RC.year# </cfif>Blog Entries</h2>
	<cfif arrayLen(RC.articles) GT 0>
		<cfloop array="#RC.articles#" index="RC.article">
			#view("blog/summary")#
		</cfloop>
	<cfelse>
		<p>Sorry, No Blogs Posts have been found in this criteia.</p>
	</cfif>
</cfoutput>