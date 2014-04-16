<cfcomponent output="false">
	<cfset VARIABLES.collectionName = "" />


	<cffunction name="init" output="false">
		<cfargument name="collectionName">

		<cfscript>
			if (len(ARGUMENTS.collectionName) > 0) {
				this.setCollectionName(ARGUMENTS.collectionName);
			}
		</cfscript>

		<!---
		<cfcollection action="list" name="collections" engine="solr">
		<cfif not listFindNoCase(valueList(collections.name), VARIABLES.collectionName)>
			<cfcollection action="create" collection="#VARIABLES.collectionName#" engine="solr" path="#expandPath('/collections')#/#VARIABLES.collectionName#">
		</cfif>
		--->
		<cfif not this.collectionExists(VARIABLES.collectionName)>
			<cfcollection action="create" collection="#VARIABLES.collectionName#" engine="solr" path="#expandPath('/collections')#/#VARIABLES.collectionName#">
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
		<cfargument name="id" required="true">
		<cfargument name="title" required="true">
		<cfargument name="body" required="true">
		<cfargument name="author" default="">
		<cfargument name="custom1" default="">
		<cfargument name="custom2" default="">
		<cfargument name="custom3" default="">
		<cfargument name="custom4" default="">

		<cfindex 
			collection="#VARIABLES.collectionName#" 
			action="update" 
			key="#ARGUMENTS.id#" 
			body="#ARGUMENTS.body#,#ARGUMENTS.title#" 
			title="#ARGUMENTS.title#" 
			type="custom"
			custom1="#ARGUMENTS.custom1#"
			custom2="#ARGUMENTS.custom2#"
			custom3="#ARGUMENTS.custom3#"
			custom4="#ARGUMENTS.custom4#"
		>
	</cffunction>


	<cffunction name="search">
		<cfargument name="searchTerm">
		<cfsearch collection="#VARIABLES.collectionName#" criteria="#ARGUMENTS.searchTerm#" name="results" status="r" suggestions="always" contextPassages="2">
		<cfreturn results />
	</cffunction>


	<!---
	SOURCE: http://www.cflib.org/udf/collectionExists

	 Call this function, passing in a collection name, to see if that named Verity colleciton exists.
	 Version 1 by Pete Ruckelshaus, &#112;&#114;&#117;&#99;&#107;&#101;&#108;&#115;&#104;&#97;&#117;&#115;&#64;&#121;&#97;&#104;&#111;&#111;&#46;&#99;&#111;&#109;
	 Raymond Camden modified version 2 a bit.
	 
	 @param collection 	 Name of collection (Required)
	 @return Returns a boolean. 
	 @author Dan G. Switzer, II (&#112;&#114;&#117;&#99;&#107;&#101;&#108;&#115;&#104;&#97;&#117;&#115;&#64;&#121;&#97;&#104;&#111;&#111;&#46;&#99;&#111;&#109;&#100;&#115;&#119;&#105;&#116;&#122;&#101;&#114;&#64;&#112;&#101;&#110;&#103;&#111;&#119;&#111;&#114;&#107;&#115;&#46;&#99;&#111;&#109;) 
	 @version 2, March 10, 2006 
	--->
	<cffunction name="collectionExists" returnType="boolean" output="false" hint="This returns a yes/no value that checks for the existence of a named collection.">
		<cfargument name="collection" type="string" required="yes">

		<!---// by default return true //--->
		<cfset var bExists = true />
		<cfset var searchItems = "">
		
		<!---// if you can't search the collection, then assume it doesn't exist //--->
		<cftry>
			<cfsearch
				name="searchItems"
				collection="#ARGUMENTS.collection#"
				criteria="#createUUID()#"
			/>
			<cfcatch type="any">
				<!---// if the message contains the string "does not exist", then the collection can't be found //--->
				<cfif cfcatch.message contains "does not exist">
					<cfset bExists = false />
				<cfelse>
					<cfrethrow>
				</cfif>
			</cfcatch>
		</cftry>

		<!---// returns true if search was successful and false if an error occurred //--->
		<cfreturn bExists />
	</cffunction>
</cfcomponent>
