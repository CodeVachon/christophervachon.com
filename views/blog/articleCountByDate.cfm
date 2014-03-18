<cfscript>
	param name="RC.blogArticleDateCounts" default=[];
	param name="RC.mostUsedTags" default=[];
</cfscript>
<cfoutput>
	<div class='panel panel-default'>
		<div class='panel-heading'>Search</div>
		<form class='panel-body' method="get" action='#buildURL('blog.search')#'>
			<div class="input-group">
				<input type="text" class="form-control" name="search_for" placeholder="Search" value="#((structKeyExists(RC,"search_for"))?RC.search_for:"")#" />
				<span class="input-group-btn">
					<button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-search'></span></button>
				</span>
			</div>
		</form>
	</div>

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

	<cfif arrayLen(RC.mostUsedTags) GT 0>
		<div class="panel panel-default">
			<div class="panel-heading">Most Used Tags</div>

			<ul class='list-group archives'>
				<cfloop array="#RC.mostUsedTags#" index="LOCAL.tag">
					<li class='list-group-item'>
						<span class="badge">#LOCAL.tag.getArticleCount()#</span>
						<a href='/blog/tags/#lcase(LOCAL.tag.getName())#'>#LOCAL.tag.getName()#</a>
					</li>
				</cfloop>
			</ul>
		</div>
	</cfif>
</cfoutput>