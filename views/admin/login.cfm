<cfoutput>
	<h2>Login</h2>
	<cfif structKeyExists(RC,"validationError")>
		#view('main/validationError')#
	</cfif>
	<form role="form" name="loginForm" method="post" action="/admin/login">
		<div class="form-group">
			<label for="emailaddress">Email Address</label>
			<input type="email" class="form-control" id="emailaddress" name="emailaddress" placeholder="Enter email" value="#((structKeyExists(RC,"emailaddress"))?RC.emailaddress:"")#" />
		</div>
		<div class="form-group">
			<label for="loginPassword">Password</label>
			<input type="password" class="form-control" id="loginPassword" name='loginPassword' placeholder="Password" />
		</div>
		<div class="checkbox">
			<label for="rememberMe"><input type="checkbox" name="rememberMe"> Persistant Login</label>
		</div>
		<button type="submit" class="btn btn-primary" name='btnSave'>Log In</button>
	</form>
</cfoutput>