<cfparam name="REQUEST.disableSidebar" default="false" />
<cfparam name="RC.adminScreen" default="false" />
<cfscript>
	
</cfscript>
<cfcontent reset="true" /><cfoutput><!doctype html>
<html>
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
	<div class='masthead'>
		<nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation">
			<div class='container'>
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##fixed-navigation">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/admin">Admin Area</a>
				</div>
				<div class="collapse navbar-collapse" id="fixed-navigation">
					<ul class="nav navbar-nav">
						<li><a href='/'>Front End</a></li>
						<li class='dropdown'>
							<a href="#buildURL('admin.listArticles')#" class='dropdown-toggle' data-toggle="dropdown">Articles <b class='caret'></b></a>
							<ul class="dropdown-menu">
								<li><a href="#buildURL('admin.listArticles')#">List Articles</a></li>
								<li><a href="#buildURL('admin.editArticle')#">New Article</a></li>
								<li><a href="#buildURL('admin.listTags')#">Article Tags</a></li>
								<li><a href="#buildURL('admin.rebuildSearchIndex')#">Rebuild Search Index</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#buildURL('admin.listContentPages')#" class='dropdown-toggle' data-toggle="dropdown">Content <b class='caret'></b></a>
							<ul class="dropdown-menu">
								<li><a href="#buildURL('admin.listContentPages')#">List Content Pages</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#buildURL('admin.settings')#" class='dropdown-toggle' data-toggle="dropdown">Settings <b class='caret'></b></a>
							<ul class="dropdown-menu">
								<li><a href="#buildURL('admin.settings')#">Website Settings</a></li>
								<li><a href="#buildURL('admin.listPeople')#">List Users</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<div class='container'>
		<div class='row'>
			#body#
		</div>
		<footer class='site-footer'>
			<p>&copy; Christopher Vachon Admin Area #year(now())#</p>
		</footer>
	</div>
	<cfscript>
		for (LOCAL.jsFile in RC.template.getFiles("JS")) {
			writeOutput(chr(10) & chr(9) & chr(9) & "<script type='text/javascript' src='#LOCAL.jsFile#'></script>");
		}
	</cfscript>
</body>
</html>
</cfoutput>
<cfabort />
