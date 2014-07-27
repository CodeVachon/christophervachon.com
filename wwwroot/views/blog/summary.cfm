<cfoutput>
	<article class='blog-post blog-summary'>
		<header>
			<p class='title'><a href='/blog/#RC.article.getURI()#'>#RC.article.getTitle()#</a></p>
			<p class='date'>Posted: #dateFormat(RC.article.getPublicationDate(),"mmmm d, yyyy")#</p>
		</header>
		<section>
			#RC.article.getSummary()#
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
</cfoutput>