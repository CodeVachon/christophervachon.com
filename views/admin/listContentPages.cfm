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
						<a href="#buildURL('admin')#" class="btn btn-default">Add Content Page</a>
					</div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<cfloop array="#RC.contentPages#" index="LOCAL.contentPage">
				<tr>
					<td><a href="#buildURL('admin')#">#LOCAL.contentPage.getName()#</a></td>
				</tr>
				<td>
					<div class="btn-group btn-group-xs pull-right">
						<a href="#buildURL('admin')#">edit</a>
					</div>
				</td>
			</cfloop>
		</tbody>
	</table>
</cfoutput>
