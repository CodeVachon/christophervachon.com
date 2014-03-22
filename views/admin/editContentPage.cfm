<cfoutput>
	<h2>Edit Content Page</h2>
	<form action="/admin/editContentPage" method='post'>
		<input type="hidden" name="contentId" value="#((structKeyExists(RC,"contentId"))?RC.contentId:"")#">
		<div class="form-group">
			<label for="name">Name</label>
			<input type="text" class="form-control" name="name" value="#((structKeyExists(RC,"name"))?RC.name:"")#" />
		</div>
		<div class="form-group">
			<label for="body">Body</label>
			<textarea name="body" placeholder="Content Body" class="form-control" data-wysiwyg="full" rows="5">#((structKeyExists(RC,"body"))?RC.body:"")#</textarea>
		</div>
		<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
	</form>
</cfoutput>