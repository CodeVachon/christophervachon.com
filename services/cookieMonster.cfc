<cfcomponent output="false" displayname="cookie">
	<!---
		Why Does this Exists?
		Because CF10 dosnt allow you to expire a cookie natively in script.
	--->

	<cffunction name="init">
		<cfreturn this />
	</cffunction>

	<cffunction name="setCookie">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfargument name="expires" type="any" required="false" default="never" />

		<cfcookie name="#trim(ARGUMENTS.name)#" value="#trim(ARGUMENTS.value)#" expires="#ARGUMENTS.expires#" />
	</cffunction>

	<cffunction name="deleteCookie">
		<cfargument name="name" type="string" required="true" />
		<cfif this.doesExists(ARGUMENTS.name)>
			<cfcookie name="#trim(ARGUMENTS.name)#" expires="now" />
		</cfif>
	</cffunction>

	<cffunction name="getValue">
		<cfargument name="name" type="string" required="true" />
		<cfscript>
			if (this.doesExists(ARGUMENTS.name)) {
				return COOKIE[trim(ARGUMENTS.name)];
			} else {
				return javaCast("null","");
			}
		</cfscript>
	</cffunction>

	<cffunction name="doesExists" returntype="boolean">
		<cfargument name="name" type="string" required="true" />
		<cfscript>
			if (structKeyExists(COOKIE,trim(ARGUMENTS.name))) {
				return true;
			} else {
				return false;
			}
		</cfscript>
	</cffunction>
</cfcomponent>