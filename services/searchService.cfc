<cfcomponent output="false">
	<cfset VARIABLES.collectionName = "" />


	<cffunction name="init" output="false">
		<cfargument name="collectionName">

		<cfscript>
			if (len(ARGUMENTS.collectionName) > 0) {
				this.setCollectionName(ARGUMENTS.collectionName);
			}
		</cfscript>

		<cfcollection action="list" name="collections" engine="solr">
		<cfif not listFindNoCase(valueList(collections.name), VARIABLES.collectionName)>
			<cfcollection action="create" collection="#VARIABLES.collectionName#" engine="solr" path="#VARIABLES.collectionName#">
		</cfif>

		<cfscript>
			return this;
		</cfscript>
	</cffunction>


	<cffunction name="setCollectionName" output="false">
		<cfargument name="collectionName">
		<cfset VARIABLES.collectionName = ARGUMENTS.collectionName>
	</cffunction>


	<cffunction name="loadIndex" output="false">
		<cfargument name="query" type="query">
		<cfindex collection="#VARIABLES.collectionName#" action="purge">
		<cfindex collection="#VARIABLES.collectionName#" action="update" body="body,title" title="title" key="id" query="ARGUMENTS.query">
	</cffunction>


	<cffunction name="removeIndex" output="false">
		<cfargument name="id">
		<cfindex collection="#VARIABLES.collectionName#" action="delete" key="#ARGUMENTS.id#" type="custom">
	</cffunction>


	<cffunction name="updateIndex" output="false">
		<cfargument name="id">
		<cfargument name="title">
		<cfargument name="body">

		<cfindex collection="#VARIABLES.collectionName#" action="update" key="#ARGUMENTS.id#" body="#ARGUMENTS.body#,#ARGUMENTS.title#" title="#ARGUMENTS.title#" type="custom">
	</cffunction>


	<cffunction name="search">
		<cfargument name="searchTerm">
		<cfsearch collection="#VARIABLES.collectionName#" criteria="#ARGUMENTS.searchTerm#" name="results" status="r" suggestions="always" contextPassages="2">
		<cfreturn results />
	</cffunction>
</cfcomponent>
