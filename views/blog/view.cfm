<cfscript>
	param name="RC.article" default=entityNew("Article");
	param name="RC.relatedArticles" default=arrayNew(1);
</cfscript>
<cfoutput>
	<article class='blog-post'>
		<header>
			<h1>#RC.article.getTitle()#</h1>
			<p class='date'>By: <a href="https://plus.google.com/+ChristopherVachon/?rel=author" target="_blank" class='googleplus'>Christopher Vachon</a> | Posted: #dateFormat(RC.article.getPublicationDate(),"mmmm d, yyyy")#</p>
		</header>
		<section>
			#RC.article.getBody()#
		</section>
		<footer>
			<cfif RC.security.checkPermission("siteAdmin")>
				<div class='btn-group btn-group-xs pull-right'>
					<a href='#buildURL('admin.editArticle')#/articleID/#RC.article.getID()#' class='btn btn-default'>Edit</a>
				</div>
			</cfif>
			<p><cfif RC.article.hasTag()>Tags: <cfloop array="#RC.article.getTags()#" index="LOCAL.tag"><a href='/blog/tags/#lcase(LOCAL.tag.getName())#'><span class="label label-default">#LOCAL.tag.getName()#</span></a> </cfloop></cfif></p>
		</footer>
	</article>

	<div class='divider'></div>

	<cfif arrayLen(RC.relatedArticles) GT 0>
		<section class='related-articles'>
			<h2>Related Posts</h2>
			<div class='row'>
				<cfloop array="#RC.relatedArticles#" index="RC.article">
					#view("blog/summary")#
				</cfloop>
			</div>
		</section>
	</cfif>
</cfoutput>