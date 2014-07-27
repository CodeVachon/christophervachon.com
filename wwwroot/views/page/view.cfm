<cfscript>
	param name="RC.content" default="";

	writeOutput("<h1>#RC.content.getName()#</h1>");
	writeOutput(RC.content.getBody());
</cfscript>
