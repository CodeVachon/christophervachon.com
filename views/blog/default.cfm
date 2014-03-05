<cfoutput>
	<h2><cfif structKeyExists(RC,"month")>#monthAsString(RC.month)# </cfif><cfif structKeyExists(RC,"year")>#RC.year# </cfif>Blog Entries</h2>
	<cfloop array="#RC.articles#" index="RC.article">
		#view("blog/summary")#
	</cfloop>
</cfoutput>