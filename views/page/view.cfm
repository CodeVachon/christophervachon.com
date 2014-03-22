<cfscript>
	param name="RC.content" default="";

	writeOutput("<h2>#RC.content.getName()#</h2>");
	writeOutput(RC.content.getBody());
</cfscript>