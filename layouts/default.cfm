<cfcontent reset="true" type="text/html" /><cfoutput><!doctype HTML>
<html lang="en">
	<head>
		<title>#RC.template.getSiteTitle()#</title>
		<cfscript> 
			if (arrayLen(RC.template.getFiles("CSS")) > 0) {
				writeOutput("<style>" & chr(10));
				writeOutput("@import url('http://fonts.googleapis.com/css?family=Maven+Pro:400,700');" & chr(10));
				for (LOCAL.cssFile in RC.template.getFiles("CSS")) {
					writeOutput(chr(9) & "@import url('#LOCAL.cssFile#');" & chr(10));
				}
				writeOutput("</style>");
			}
		</cfscript>
	</head>
	<body>
		<section class='container'>
			<header>
				<h1>#RC.template.getSiteName()#</h1>
			</header>
			<nav>
				<ul>
					<li><a href=''>#RC.template.getSiteName()#</a></li>
				</ul>
			</nav>
			<section class='content'>
				#body#
			</section>
			<footer>
				<p>&copy; Christopher Vachon #year(now())#</p>
			</footer>
		</section>
		<cfscript>
			for (LOCAL.jsFile in RC.template.getFiles("JS")) {
				writeOutput(chr(10) & chr(9) & chr(9) & "<script type='text/javascript' src='#LOCAL.jsFile#'></script>");
			}
		</cfscript>
	</body>
</html></cfoutput>