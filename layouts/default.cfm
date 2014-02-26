<cfcontent reset="true" type="text/html" /><cfoutput><!DOCTYPE html>
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
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<div class='masthead'>
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
				<div class='container'>
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##fixed-navigation">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="/">#RC.template.getSiteName()#</a>
					</div>
					<div class="collapse navbar-collapse" id="fixed-navigation">
						<ul class="nav navbar-nav">
							<li class="active"><a href='/'>Home</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown">
								<a href="##" class="dropdown-toggle" data-toggle="dropdown"><span class='hidden-sm hidden-md hidden-lg'>Settings</span><span class='hidden-xs glyphicon glyphicon-cog'></span> <b class="caret"></b></a>
								<ul class="dropdown-menu">
									<li class="divider"></li>
									<li><a href="##">Logout</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
		<div class='container'>
			<header>
				<h1>#RC.template.getSiteName()#</h1>
			</header>
			<div class='row'>
				<section class='col-xs-12 col-md-8'>
					#body#
				</section>
				<section class='col-xs-12 col-md-offset-1 col-md-3'>
					sidebar
				</section>
			</div>
			<footer>
				<p>&copy; Christopher Vachon #year(now())#</p>
			</footer>
		</div>
		<cfscript>
			for (LOCAL.jsFile in RC.template.getFiles("JS")) {
				writeOutput(chr(10) & chr(9) & chr(9) & "<script type='text/javascript' src='#LOCAL.jsFile#'></script>");
			}
		</cfscript>
	</body>
</html></cfoutput>