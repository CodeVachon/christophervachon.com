<cfoutput>
	<h2>Admin</h2>
	<ul>
		<li>
			<a href='#buildURL('admin.listArticles')#'>List Articles</a>
			<ul>
				<li><a href='#buildURL('admin.editArticles')#'>Add New Articles</a></li>
			</ul>
		</li>
		<li><a href='#buildURL('admin.listPeople')#'>List People</a></li>
	</ul>
</cfoutput>
