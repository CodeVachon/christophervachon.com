<cfoutput>
	<h2>List Articles</h2>
	<table class='table'>
		<thead>
			<tr>
				<th>Title</th>
				<th>Publish Date</th>
				<th></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td>
					<div class='btn-group'>
						<a href='#buildURL('admin.editArticle')#' class='btn btn-default'>Add New</a>
					</div>
				</td>
				<td></td>
			</tr>
		</tfoot>
		<tbody>
			<cfloop array="#RC.articles#" index="LOCAL.article">
				<tr>
					<td>#LOCAL.article.getTitle()#</td>
					<td></td>
					<td>
						<div class='btn-group btn-group-xs pull-right'>
							<a href='#buildURL('admin.editArticle')#/articleID/#LOCAL.article.getID()#' class='btn btn-default'>Edit</a>
						</div>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>