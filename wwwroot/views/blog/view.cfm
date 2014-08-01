<cfscript>
	param name="RC.article" default=entityNew("Article");
	param name="RC.relatedArticles" default=arrayNew(1);
</cfscript>
<cfoutput>
	<article class='blog-post' itemscope itemtype="http://schema.org/Article" >
		<header>
			<h1 itemprop="name">#RC.article.getTitle()#</h1>
			<p class='date'>By: <a href="https://plus.google.com/+ChristopherVachon/?rel=author" target="_blank" class='googleplus' itemprop="author" itemscope itemtype="http://schema.org/Person" itemprop="name">Christopher Vachon</a> | Posted: <span itemprop="datePublished" content="#dateFormat(RC.article.getPublicationDate(),"yyyy-mm-dd")#">#dateFormat(RC.article.getPublicationDate(),"mmmm d, yyyy")#</span></p>
		</header>
		<section itemprop="articleBody">
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

	<section class='article-comments'>
		<h2>Comments</h2>
		<div id="disqus_thread"></div>
		<script type="text/javascript">
			/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
			var disqus_shortname = 'christophervachon'; // required: replace example with your forum shortname
			var disqus_identifier = '#RC.article.getId()#';
			var disqus_title = '#RC.pageTitle#';
			var disqus_url = 'http://#CGI.HTTP_HOST##lcase(reReplace(CGI.PATH_INFO ,"/$","","one"))#';
			/* * * DON'T EDIT BELOW THIS LINE * * */

			(function() {
				var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
				dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
				(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
			})();
		</script>
		<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
		
	</section>

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