<cfoutput>
	<h2>List People</h2>
	<table class='table'>
		<thead>
		</thead>
		<tfoot>
		</tfoot>
		<tbody>
			<cfloop array="#RC.people#" index="LOCAL.person">
				<tr>
					<td>#LOCAL.person.getName()#</td>
					<td>
						<div class='btn-group btn-group-xs pull-right'>
							<a href='#buildURL('admin.editPerson')#/personID/#LOCAL.person.getID()#' class='btn btn-default'>Edit</a>
						</div>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>