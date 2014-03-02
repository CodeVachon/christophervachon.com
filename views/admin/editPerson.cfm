<cfoutput>
	<h2>Edit Person</h2>
	<div class='well'>
		<h3>Details</h3>
		<form>
			<input type='hidden' name="personID" value="#((structKeyExists(RC,"personID"))?RC.personID:"")#">
			<div class="form-group">
				<label for="firstName">First Name</label>
				<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" value="#((structKeyExists(RC,"firstName"))?RC.firstName:"")#" />
			</div>
			<div class="form-group">
				<label for="lastName">Last Name</label>
				<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" value="#((structKeyExists(RC,"lastName"))?RC.lastName:"")#" />
			</div>
			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</div>

	<div class='well'>
		<h3>Password</h3>
		<form>
			<input type='hidden' name="personID" value="#((structKeyExists(RC,"personID"))?RC.personID:"")#">
			<div class="form-group">
				<label for="loginPassword">Password</label>
				<input type="password" class="form-control" id="loginPassword" name='password' placeholder="Password" />
			</div>
			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</div>
</cfoutput>