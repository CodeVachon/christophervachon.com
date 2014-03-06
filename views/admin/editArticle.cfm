<cfoutput>
	<h2>Edit Article</h2>
	<cfif structKeyExists(RC,"validationError")>
		#view('main/validationError')#
	</cfif>

	<form role="form" name="articleForm" method="post" action="/admin/editArticle">
		<input type='hidden' name="articleId" value="#((structKeyExists(RC,"articleId"))?RC.articleId:"")#">
		<div class="form-group">
			<label for="title">Title</label>
			<input type="text" class="form-control" name="title" placeholder="Article Title" value="#((structKeyExists(RC,"title"))?RC.title:"")#" />
		</div>
		<div class="form-group">
			<label for="summary">Summary</label>
			<textarea name="summary" placeholder="Article Summary" class="form-control" rows="3">#((structKeyExists(RC,"title"))?RC.title:"")#</textarea>
		</div>
		<div class="form-group">
			<label for="body">Article Body</label>
			<textarea name="body" placeholder="Article Body" class="form-control" data-wysiwyg="full" rows="5">#((structKeyExists(RC,"body"))?RC.body:"")#</textarea>
		</div>
		<div class="form-group">
			<label for="publicationDate">Publication Date</label>
			<input type="text" class="form-control" name="publicationDate" placeholder="#dateFormat(now(),"yyyy/mm/dd")#" data-datepicker='' value="#((structKeyExists(RC,"publicationDate"))?dateFormat(RC.publicationDate,"yyyy/mm/dd"):"")#" />
		</div>
		<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
	</form>
</cfoutput>
