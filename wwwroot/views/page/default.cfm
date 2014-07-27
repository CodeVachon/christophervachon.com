<cfscript>
	param name="RC.contentPages" default=arrayNew(1);
</cfscript>
<cfoutput>
	<h2>Pages</h2>
	<ul>
		<cfloop array="#RC.contentPages#" index="LOCAL.contentPage">
			<li>
				<a href='/page/#LOCAL.contentPage.getNameURI()#'>#LOCAL.contentPage.getName()#</a>
			</lI>
		</cfloop>
	</ul>
</cfoutput>