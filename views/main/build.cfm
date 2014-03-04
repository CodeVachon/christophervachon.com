<cfscript>
	
	/* Q: Why is this file not in a Controller? */
	/* A: I want to be able to quickly distroy this file after its been uploaded and used. */

	RC.template.addPageCrumb("Build","/home/Build");

	LOCAL.password = FormatBaseN(right(int(getTickCount()/RandRange(3,17)),RandRange(6,8)),RandRange(12,18));
	LOCAL.showPassword = false;
	LOCAL.emailAddress = "admin@local.host";
	LOCAL.personService = new services.personService();

	if (!LOCAL.personService.doesPersonExist(emailAddress=LOCAL.emailAddress)) {
		LOCAL.person = LOCAL.personService.editPersonAndSave({
			firstName = "Site",
			lastName = "Administrator",
			emailAddress = LOCAL.emailAddress,
			password = LOCAL.password,
			siteAdmin=true
		});
		LOCAL.showPassword = true;
	} else {
		LOCAL.person = LOCAL.personService.getPerson(emailAddress=LOCAL.emailAddress);
	}
</cfscript>
<cfoutput>
	<h2>Build</h2>
	<p>Person Created</p>
	<dl>
		<dt>Email Address</dt>
		<dd>#LOCAL.emailAddress#</dd>
		<cfif LOCAL.showPassword>
			<dt>Password</dt>
			<dd>#LOCAL.password#</dd>
		</cfif>
	</dl>
</cfoutput>

