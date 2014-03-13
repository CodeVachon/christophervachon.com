<cfscript>
	param name="RC.blogArticleDateCounts" default=[];
	param name="RC.mostUsedTags" default=[];
</cfscript>
<cfoutput>
	<cfif arrayLen(RC.blogArticleDateCounts) GT 0>
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
	</cfif>

	<cfif arrayLen(RC.blogArticleDateCounts) GT 0>
		<div class="panel panel-default">
			<div class="panel-heading">Most Used Tags</div>

			<ul class='list-group archives'>
				<cfloop array="#RC.mostUsedTags#" index="LOCAL.tag">
					<li class='list-group-item'>
						<span class="badge">#LOCAL.tag.getArticleCount()#</span>
						<a href='/blog/tags/#LOCAL.tag.getName()#'>#LOCAL.tag.getName()#</a>
					</li>
				</cfloop>
			</ul>
		</div>
	</cfif>
</cfoutput>