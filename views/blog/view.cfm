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
				<div class='btn-group pull-right'>
					<a href='#buildURL('admin.editArticle')#/articleID/#RC.article.getID()#' class='btn btn-default'>Edit</a>
				</div>
			</cfif>
			<p>Tags: </p>
		</footer>
	</article>
</cfoutput>