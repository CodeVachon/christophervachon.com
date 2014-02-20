<cfcontent reset="true" type="text/html" /><cfoutput><!doctype HTML>
<html lang="en">
	<head>
		<title>#RC.template.getSiteTitle()#</title>
	</head>
	<body>
		<section class='container'>
			<header>
				<h1>Christopher Vachon</h1>
			</header>
			<section class='content'>
				#body#
			</section>
			<footer>
				<p>&copy; Christopher Vachon #year(now())#</p>
			</footer>
		</section>
	</body>
</html></cfoutput>