<cfoutput>
	<h2>List Tags</h2>
	<table class='table'>
		<thead>
			<tr>
				<th>Name</th>
				<th>Article Count</tH>
				<th></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan='3'>
					<div class='btn-group'>
						<a href='#buildURL('admin.editTag')#' class='btn btn-default'>Add New</a>
					</div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<cfloop array="#RC.tags#" index="LOCAL.tag">
				<tr>
					<td><a href='/blog/tags/#LOCAL.tag.getName()#'>#LOCAL.tag.getName()#</a></td>
					<td>#LOCAL.tag.getArticleCount()#</td>
					<td>
						<div class='btn-group btn-group-xs pull-right'>
							<a href='#buildURL('admin.editTag')#/tagID/#LOCAL.tag.getID()#' class='btn btn-default'>Edit</a>
						</div>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>