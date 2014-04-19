<cfoutput>
	<h2>Website Settings</h2>

	<ul class="nav nav-tabs">
		<li class="active"><a href="##SiteDetails" data-toggle="tab">Site Details</a></li>
		<li><a href="##MailSettings" data-toggle="tab">Mail Settings</a></li>
		<li><a href="##SocialMedia" data-toggle="tab">Social Media</a></li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active" id="SiteDetails">
			<form name='editSiteDetails' method='post' action="#buildURL('admin.settings')#">
				<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
				<div class="form-group">
					<label for="domain">Site Domain</label>
					<p class="form-control-static">#((structKeyExists(RC,"domain"))?RC.domain:"unknown")#</p>
				</div>
				<div class="form-group">
					<label for="siteName">Site Name</label>
					<input type="text" class="form-control" id="siteName" name="siteName" placeholder="Site Name" value="#((structKeyExists(RC,"siteName"))?RC.siteName:"")#" />
				</div>
				<div class="form-group">
					<label for="description">Description</label>
					<input type="text" class="form-control" id="description" name="description" placeholder="Website Description" value="#((structKeyExists(RC,"description"))?RC.description:"")#" />
				</div>
				<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
			</form>
		</div>
		<div class="tab-pane" id="MailSettings">
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
		<div class="tab-pane" id="SocialMedia">
			<ul class="nav nav-pills nav-stacked col-sm-3">
				<li class="active"><a href="##Twitter" data-toggle="tab">Twitter</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active col-sm-9" id="Twitter">
					<form name='editSiteDetails' method='post' action="#buildURL('admin.settings')#">
						<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
						<div class="form-group">
							<label for="TW_UserName">User Name</label>
							<input type="text" class="form-control" id="TW_UserName" name="TW_UserName" placeholder="Site Name" value="#((structKeyExists(RC,"TW_UserName"))?RC.TW_UserName:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_ConsumerKey">Consumer Key</label>
							<input type="text" class="form-control" id="TW_ConsumerKey" name="TW_ConsumerKey" placeholder="Site Name" value="#((structKeyExists(RC,"TW_ConsumerKey"))?RC.TW_ConsumerKey:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_ConsumerSecret">Consumer Secret</label>
							<input type="text" class="form-control" id="TW_ConsumerSecret" name="TW_ConsumerSecret" placeholder="Site Name" value="#((structKeyExists(RC,"TW_ConsumerSecret"))?RC.TW_ConsumerSecret:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_AccessToken">Access Token</label>
							<input type="text" class="form-control" id="TW_AccessToken" name="TW_AccessToken" placeholder="Site Name" value="#((structKeyExists(RC,"TW_AccessToken"))?RC.TW_AccessToken:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_AccessTokenSecret">Access Token Secret</label>
							<input type="text" class="form-control" id="TW_AccessTokenSecret" name="TW_AccessTokenSecret" placeholder="Site Name" value="#((structKeyExists(RC,"TW_AccessTokenSecret"))?RC.TW_AccessTokenSecret:"")#" />
						</div>
						<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</cfoutput>