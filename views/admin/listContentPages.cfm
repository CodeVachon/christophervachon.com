<cfoutput>
	<h2>Content Pages</h2>
	<table class="table">
		<thead>
			<tr>
				<th>Name</th>
				<th></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan="2">
					<div class="btn-group">
						<a href="#buildURL('admin.editContentPage')#" class="btn btn-default">Add Content Page</a>
					</div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<cfloop array="#RC.contentPages#" index="LOCAL.contentPage">
				<tr>
					<td><a href="#buildURL('page')#/#LOCAL.contentPage.getNameURI()#">#LOCAL.contentPage.getName()#</a></td>
					<td>
						<div class="btn-group btn-group-xs pull-right">
							<a href="#buildURL('admin.editContentPage')#/contentId/#LOCAL.contentPage.getID()#" class='btn btn-default'>edit</a>
							<a href="#buildURL('admin.editContentPage')#/contentId/#LOCAL.contentPage.getID()#?btnSave=true&amp;isDeleted=true" class='btn btn-danger'>remove</a>
						</div>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>
