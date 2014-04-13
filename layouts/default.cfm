<cfparam name="REQUEST.disableSidebar" default="false" />
<cfcontent reset="true" type="text/html" /><!DOCTYPE html><cfoutput>
<html lang="en">
	<head>
		<title>#RC.template.getSiteTitle()#</title>
		<link rel="canonical" href="http://#CGI.HTTP_HOST##lcase(reReplace(CGI.PATH_INFO ,"/$","","one"))#" />
		<cfscript>
			for (_metaTag in RC.template.getMetaTags()) {
				tag = "<meta ";
				for (_key in _metaTag) {
					tag &= '#_key#="#_metaTag[_key]#" ';
				}
				tag &= "/>" & chr(10);
				writeOutput(tag);
			}

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
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			ga('create', 'UA-47031068-2', 'christophervachon.com');
			ga('send', 'pageview');
		</script>
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
							<li<cfif RC.action EQ 'main.default'> class="active"</cfif>><a href='/'>Home</a></li>
							<li<cfif structKeyExists(RC,"pageName") AND (RC.pageName EQ "about me")> class="active"</cfif>><a href='/page/about-me'>About Me</a></li>
							<li<cfif structKeyExists(RC,"pageName") AND (RC.pageName EQ "projects")> class="active"</cfif>><a href='/page/projects'>Projects</a></li>
							<li<cfif listGetAt(RC.action,1,".") EQ 'blog'> class="active"</cfif>><a href='#buildURL('blog')#'>Blog</a></li>
							<li<cfif listGetAt(RC.action,2,".") EQ 'contact'> class="active"</cfif>><a href='/contact'>Contact</a></li>
						</ul>
						<cfif RC.security.checkPermission("siteAdmin")>
							<ul class="nav navbar-nav navbar-right">
								<li class="dropdown">
									<a href="##" class="dropdown-toggle" data-toggle="dropdown"><span class='hidden-sm hidden-md hidden-lg'>Settings</span><span class='hidden-xs glyphicon glyphicon-cog'></span> <b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li><a href="#buildURL('admin')#">Admin</a></li>
										<li><a href="#buildURL('admin.editPerson')#/personID/#SESSION.member.personID#">Edit Details</a></li>
										<li class="divider"></li>
										<li><a href="#buildURL('admin.logout')#">Logout</a></li>
									</ul>
								</li>
							</ul>
						</cfif>
					</div>
				</div>
			</nav>
		</div>
		<div class='container'>
			<header class='sr-only'>
				<h1>#RC.template.getSiteName()#</h1>
			</header>
			<div class='row'>
				<cfif REQUEST.disableSidebar>
					<section class='col-xs-12 page-content'>
						<cfif RC.template.getPageCrumbCount() GT 1>
							<ol class="breadcrumb">
								<cfloop from='1' to='#RC.template.getPageCrumbCount()#' index="LOCAL.thisIndex">
									<li<cfif LOCAL.thisIndex EQ RC.template.getPageCrumbCount()> class='active'</cfif>><cfif LOCAL.thisIndex NEQ RC.template.getPageCrumbCount()><a href='#RC.template.getPageCrumb(LOCAL.thisIndex).url#'></cfif>#RC.template.getPageCrumb(LOCAL.thisIndex).label#<cfif LOCAL.thisIndex NEQ RC.template.getPageCrumbCount()></a></cfif></li>
								</cfloop>
							</ol>
						</cfif>
						#body#
					</section>
				<cfelse>
					<section class='col-xs-12 col-sm-8 page-content'>
						<cfif RC.template.getPageCrumbCount() GT 1>
							<ol class="breadcrumb">
								<cfloop from='1' to='#RC.template.getPageCrumbCount()#' index="LOCAL.thisIndex">
									<li<cfif LOCAL.thisIndex EQ RC.template.getPageCrumbCount()> class='active'</cfif>><cfif LOCAL.thisIndex NEQ RC.template.getPageCrumbCount()><a href='#RC.template.getPageCrumb(LOCAL.thisIndex).url#'></cfif>#RC.template.getPageCrumb(LOCAL.thisIndex).label#<cfif LOCAL.thisIndex NEQ RC.template.getPageCrumbCount()></a></cfif></li>
								</cfloop>
							</ol>
						</cfif>
						#body#
					</section>
					<section class='col-xs-12 col-sm-offset-0 col-md-offset-1 col-sm-4 col-md-3'>
						#view('blog/articleCountByDate')#
					</section>
				</cfif>
			</div>
			<footer class='site-footer'>
				<p>&copy; Christopher Vachon #year(now())#</p>
			</footer>
			<cfif RC.security.checkPermission("siteAdmin")>
				<button class='btn admin-btn'><span class="glyphicon glyphicon-chevron-right"></span></button>
				<div class='admin-menu'>
					<h2>Admin</h2>
					<div class="panel-group" id="admin-menu-accordion">
						<div class="panel">
							<div class="panel-heading">
								<h4 class="panel-title"><a data-toggle="collapse" data-parent="##admin-menu-accordion" href="##admin-menu-accordion-articles">Articles</a></h4>
							</div>
							<div id="admin-menu-accordion-articles" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<cfif RC.action EQ "blog.view">
											<li><a href='#buildURL('admin.editArticle')#/articleId/#RC.article.getID()#'>Edit Article</a></li>
										</cfif>
										<li><a href='#buildURL('admin.listArticles')#'>List Articles</a></li>
										<li><a href='#buildURL('admin.editArticle')#'>Add New Article</a></li>
										<li><a href='#buildURL('admin.listTags')#'>List Tags</a></li>
										<li><a href='#buildURL('admin.rebuildSearchIndex')#'>Rebuild Search Index</a></li>
									</ul>
								</div>
							</div>
						</div><!-- close .panel -->
						<div class="panel">
							<div class="panel-heading">
								<h4 class="panel-title"><a data-toggle="collapse" data-parent="##admin-menu-accordion" href="##admin-menu-accordion-content">Content</a></h4>
							</div>
							<div id="admin-menu-accordion-content" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="#buildURL('admin.listContentPages')#">List Content Pages</a></li>
										<li><a href='#buildURL('admin.editContentPage')#'>Add New Content Page</a></li>
									</ul>
								</div>
							</div>
						</div><!-- close .panel -->
						<div class="panel">
							<div class="panel-heading">
								<h4 class="panel-title"><a data-toggle="collapse" data-parent="##admin-menu-accordion" href="##admin-menu-accordion-settings">Site Settings</a></h4>
							</div>
							<div id="admin-menu-accordion-settings" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href='#buildURL('admin.listPeople')#'>List Users</a></li>
										<li><a href='#buildURL('admin.settings')#'>Website Settings</a></li>
									</ul>
								</div>
							</div>
						</div><!-- close .panel -->
					</div><!-- close ##admin-menu-accordion -->
				</div>
			</cfif>
		</div>
		<cfscript>
			for (LOCAL.jsFile in RC.template.getFiles("JS")) {
				writeOutput(chr(10) & chr(9) & chr(9) & "<script type='text/javascript' src='#LOCAL.jsFile#'></script>");
			}
		</cfscript>
	</body>
</html></cfoutput>