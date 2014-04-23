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
				<li><a href="##Facebook" data-toggle="tab">Facebook</a></li>
			</ul>
			<div class="tab-content col-sm-9">
				<div class="tab-pane active" id="Twitter">
					<h3>Twitter API Settings</h3>
					<form name='editSiteDetails' method='post' action="#buildURL('admin.settings')#">
						<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
						<div class="form-group">
							<label for="TW_UserName">User Name</label>
							<input type="text" class="form-control" id="TW_UserName" name="TW_UserName" placeholder="" value="#((structKeyExists(RC,"TW_UserName"))?RC.TW_UserName:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_ConsumerKey">API Key</label>
							<input type="text" class="form-control" id="TW_ConsumerKey" name="TW_ConsumerKey" placeholder="" value="#((structKeyExists(RC,"TW_ConsumerKey"))?RC.TW_ConsumerKey:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_ConsumerSecret">API Secret</label>
							<input type="text" class="form-control" id="TW_ConsumerSecret" name="TW_ConsumerSecret" placeholder="" value="#((structKeyExists(RC,"TW_ConsumerSecret"))?RC.TW_ConsumerSecret:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_AccessToken">Access Token</label>
							<input type="text" class="form-control" id="TW_AccessToken" name="TW_AccessToken" placeholder="" value="#((structKeyExists(RC,"TW_AccessToken"))?RC.TW_AccessToken:"")#" />
						</div>
						<div class="form-group">
							<label for="TW_AccessTokenSecret">Access Token Secret</label>
							<input type="text" class="form-control" id="TW_AccessTokenSecret" name="TW_AccessTokenSecret" placeholder="" value="#((structKeyExists(RC,"TW_AccessTokenSecret"))?RC.TW_AccessTokenSecret:"")#" />
						</div>
						<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
					</form>
				</div>
				<div class="tab-pane" id="Facebook">
					<h3>Facebook API Settings</h3>
					<form name='editSiteDetails' method='post' action="#buildURL('admin.settings')#">
						<input type='hidden' name="websiteSettingsID" value="#((structKeyExists(RC,"websiteSettingsID"))?RC.websiteSettingsID:"")#">
						<div class="form-group">
							<label for="FB_appID">App ID</label>
							<input type="text" class="form-control" id="FB_appID" name="FB_appID" placeholder="" value="#((structKeyExists(RC,"FB_appID"))?RC.FB_appID:"")#" />
						</div>
						<div class="form-group">
							<label for="FB_appSecret">App Secret</label>
							<input type="text" class="form-control" id="FB_appSecret" name="FB_appSecret" placeholder="" value="#((structKeyExists(RC,"FB_appSecret"))?RC.FB_appSecret:"")#" />
						</div>
						<div class="form-group">
							<label for="FB_AppUserToken">App User Token</label>
							<input type="text" class="form-control" id="FB_AppUserToken" name="FB_AppUserToken" placeholder="" value="#((structKeyExists(RC,"FB_AppUserToken"))?RC.FB_AppUserToken:"")#" />
						</div>
						<div class="form-group">
							<label for="FB_objectID">Object to Connect to ID</label>
							<input type="text" class="form-control" id="FB_objectID" name="FB_objectID" placeholder="" value="#((structKeyExists(RC,"FB_objectID"))?RC.FB_objectID:"")#" />
						</div>
						<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</cfoutput>