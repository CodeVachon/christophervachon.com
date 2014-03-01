<cfparam name="RC.validationError" default="Oops!" />
<cfoutput>
	<div class="alert alert-danger">
		<cfif isSimpleValue(RC.validationError)>
			#RC.validationError#
		<cfelseif isStruct(RC.validationError)>
			<h3>#((structKeyExists(RC.validationError,"label"))?RC.validationError.label:"Oops!")#</h3>
			<ul>
				<cfloop array="#RC.validationError.values#" index="LOCAL.error">
					<li>#LOCAL.error#</li>
				</cfloop>
			</ul>
		<cfelseif isArray(RC.validationError)>
			<h3>Oops!</h3>
			<ul>
				<cfloop array="#RC.validationError#" index="LOCAL.error">
					<li>#LOCAL.error#</li>
				</cfloop>
			</ul>
		</cfif>
	</div>
</cfoutput>