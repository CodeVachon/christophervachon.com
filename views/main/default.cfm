<cfoutput>
	<h2>#APPLICATION.websiteSettings.getSiteName()#</h2>

	<cfif arrayLen(RC.articles) GT 0>
		<cfloop array="#RC.articles#" index="RC.article">
			#view("blog/summary")#
		</cfloop>
	</cfif>
</cfoutput>