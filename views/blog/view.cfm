<cfoutput>
	<article class='blog-post'>
		<header>
			<h2>#RC.article.getTitle()#</h2>
			<p class='date'>Posted: #dateFormat(RC.article.getPublicationDate(),"mmmm d, yyyy")#</p>
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
			<p><cfif RC.article.hasTag()>Tags: <cfloop array="#RC.article.getTags()#" index="LOCAL.tag"><a href='/blog/tags/#LOCAL.tag.getName()#'><span class="label label-default">#LOCAL.tag.getName()#</span></a> </cfloop></cfif></p>
		</footer>
	</article>

	<h2>Related Posts</h2>
	<div class='row'>
		<cfscript>
			LOCAL.colspan = int(12/arrayLen(RC.relatedArticles));
		</cfscript>
		<cfloop array="#RC.relatedArticles#" index="RC.article">
			<div class='col-sm-12 col-md-#LOCAL.colspan#'>
				#view("blog/summary")#
			</div>
		</cfloop>
	</div>
</cfoutput>