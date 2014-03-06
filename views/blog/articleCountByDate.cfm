<cfscript>
	param name="RC.blogArticleDateCounts" default=[];
</cfscript>
<cfoutput>
	<div class="panel panel-default">
		<div class="panel-heading">Archives</div>
		<div class="panel-body">
			<ul class='archives'>
				<cfloop array="#RC.blogArticleDateCounts#" index="LOCAL.yearData">
					<li>
						<a href='/blog/#dateFormat(LOCAL.yearData.date,"yyyy")#'>#LOCAL.yearData.year# (#LOCAL.yearData.articleCount#)</a>
						<cfif structKeyExists(LOCAL.yearData,"months")>
							<ul>
								<cfloop array="#LOCAL.yearData.months#" index="LOCAL.monthData">
									<li><a href='/blog/#dateFormat(LOCAL.monthData.date,"yyyy")#/#dateFormat(LOCAL.monthData.date,"mm")#'>#LOCAL.monthData.month# (#LOCAL.monthData.articleCount#)</a></li>
								</cfloop>
							</ul>
						</cfif>
					</li>
				</cfloop>
			<ul>
		</div>
	</div>
</cfoutput>