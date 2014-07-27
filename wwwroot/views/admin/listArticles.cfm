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
				<td colspan='3'>
					<div class='btn-group'>
						<a href='#buildURL('admin.editArticle')#' class='btn btn-default'>Add New</a>
					</div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<cfloop array="#RC.articles#" index="LOCAL.article">
				<tr>
					<td><a href='/blog/#LOCAL.article.getURI()#'>#LOCAL.article.getTitle()#</a></td>
					<td>#dateFormat(LOCAL.article.getPublicationDate(),"mmm d yyyy")#</td>
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