<cfoutput>
	<cfif structKeyExists(RC,"validationError")>
		#view('main/validationError')#
	</cfif>
	<form role="form" name="emailAddressForm" method="post" action="/admin/editEmailAddress">
		<input type='hidden' name="emailAddressID" value="#((structKeyExists(RC,"emailAddressID"))?RC.emailAddressID:"")#">
		<div class="form-group">
			<label for="emailaddress">Email Address</label>
			<input type="email" class="form-control" name="emailaddress" placeholder="Enter email" value="#((structKeyExists(RC,"emailaddress"))?RC.emailaddress:"")#" />
		</div>
		<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
	</form>
</cfoutput>