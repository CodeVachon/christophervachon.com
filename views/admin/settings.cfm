<cfoutput>
	<h2>Website Settings</h2>
	<div class='well'>
		<h3>Site Details</h3>
		<form name='editSiteDetails' method='post' action="#buildURL('admin.settings')#">
			<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
			<div class="form-group">
				<label for="siteName">Site Name</label>
				<input type="text" class="form-control" id="siteName" name="siteName" placeholder="Site Name" value="#((structKeyExists(RC,"siteName"))?RC.siteName:"")#" />
			</div>
			<div class="form-group">
				<label for="domain">Site Domain</label>
				<p class="form-control-static">#((structKeyExists(RC,"domain"))?RC.domain:"unknown")#</p>
			</div>
			<div class="form-group">
				<label for="description">Description</label>
				<input type="text" class="form-control" id="description" name="description" placeholder="Website Description" value="#((structKeyExists(RC,"description"))?RC.description:"")#" />
			</div>
			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</div>


	<div class='well'>
		<h3>Mail Settings</h3>
		<form name='editMailSettings' method='post' action="#buildURL('admin.settings')#">
			<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
			<div class="form-group">
				<label for="description">SMTP Server Address</label>
				<input type="text" class="form-control" id="Mail_SMTPServer" name="Mail_SMTPServer" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_SMTPServer"))?RC.Mail_SMTPServer:"")#" />
			</div>
			<div class="form-group">
				<label for="description">SMTP Port</label>
				<input type="text" class="form-control" id="Mail_Port" name="Mail_Port" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_Port"))?RC.Mail_Port:"")#" />
			</div>
			<div class="form-group">
				<label for="description">SMTP Username</label>
				<input type="text" class="form-control" id="Mail_Username" name="Mail_Username" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_Username"))?RC.Mail_Username:"")#" />
			</div>
			<div class="form-group">
				<label for="description">SMTP Password</label>
				<input type="password" class="form-control" id="Mail_Password" name="Mail_Password" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_Password"))?RC.Mail_Password:"")#" />
			</div>
			<div class="form-group">
				<label for="description">SSL Settings</label>
				<select name="Mail_UseSSL" class="form-control">
					<option value="true"#((structKeyExists(RC,"Mail_UseSSL") && RC.Mail_UseSSL)?" selected='selected'":"")#>Use SSL</option>
					<option value="false"#((structKeyExists(RC,"Mail_UseSSL") && !RC.Mail_UseSSL)?" selected='selected'":"")#>None</option>
				</select>
			</div>
			<div class="form-group">
				<label for="description">From Name</label>
				<input type="text" class="form-control" id="Mail_FromName" name="Mail_FromName" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_FromName"))?RC.Mail_FromName:"")#" />
			</div>
			<div class="form-group">
				<label for="description">From Email Address</label>
				<input type="text" class="form-control" id="Mail_FromEmailAddress" name="Mail_FromEmailAddress" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_FromEmailAddress"))?RC.Mail_FromEmailAddress:"")#" />
			</div>
			<div class="form-group">
				<label for="description">Send To Address</label>
				<input type="text" class="form-control" id="Mail_SendToEmailAddress" name="Mail_SendToEmailAddress" placeholder="Website Description" value="#((structKeyExists(RC,"Mail_SendToEmailAddress"))?RC.Mail_SendToEmailAddress:"")#" />
			</div>
			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</div>

</cfoutput>