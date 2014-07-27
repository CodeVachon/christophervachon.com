<cfoutput>
	<cfif structKeyExists(RC,"validationError")>
		#view('main/validationError')#
	</cfif>
	<form role="form" name="tagForm" method="post" action="/admin/editTag">
		<input type='hidden' name="tagID" value="#((structKeyExists(RC,"tagID"))?RC.tagID:"")#">
		<div class="form-group">
			<label for="name">Tag Name</label>
			<input type="text" class="form-control" name="name" placeholder="Tag Name" value="#((structKeyExists(RC,"name"))?RC.name:"")#" />
		</div>
		<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
	</form>
</cfoutput>