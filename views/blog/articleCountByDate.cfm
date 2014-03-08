<cfscript>
	param name="RC.blogArticleDateCounts" default=[];
</cfscript>
<cfoutput>
	<div class="panel panel-default">
		<div class="panel-heading">Archives</div>

		<ul class='list-group archives'>
			<cfloop array="#RC.blogArticleDateCounts#" index="LOCAL.yearData">
				<li class='list-group-item'>
					<span class="badge">#LOCAL.yearData.articleCount#</span>
					<a href='/blog/#dateFormat(LOCAL.yearData.date,"yyyy")#'>#LOCAL.yearData.year#</a>
					<cfif structKeyExists(LOCAL.yearData,"months")>
						<ul class='list-group'>
							<cfloop array="#LOCAL.yearData.months#" index="LOCAL.monthData">
								<li class='list-group-item'>
									<span class="badge">#LOCAL.monthData.articleCount#</span>
									<a href='/blog/#dateFormat(LOCAL.monthData.date,"yyyy")#/#dateFormat(LOCAL.monthData.date,"mm")#'>#LOCAL.monthData.month#</a>
								</li>
							</cfloop>
						</ul>
					</cfif>
				</li>
			</cfloop>
		</ul>
	</div>
</cfoutput>