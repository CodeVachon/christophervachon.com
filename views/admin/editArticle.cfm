<cfoutput>
	<section class='col-sm-6' id='articleForm'>
		<h2>Edit Article</h2>
		<cfif structKeyExists(RC,"validationError")>
			#view('main/validationError')#
		</cfif>

		<form role="form" name="articleForm" method="post" action="/admin/editArticle">
			<input type='hidden' name="articleId" value="#((structKeyExists(RC,"articleId"))?RC.articleId:"")#">

			<ul class="nav nav-tabs">
				<li class="active"><a href="##articleBody" data-toggle="tab">Body</a></li>
				<li><a href="##articleMetaData" data-toggle="tab">Meta Data</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane active" id="articleBody">
					<div class="form-group">
						<label for="title">Title</label>
						<input type="text" class="form-control" name="title" placeholder="Article Title" value="#((structKeyExists(RC,"title"))?RC.title:"")#" />
					</div>
					<div class="form-group">
						<label for="body">Article Body</label>
						<textarea name="body" id="body" placeholder="Article Body" class="form-control" rows="5">#((structKeyExists(RC,"body"))?RC.body:"")#</textarea>
					</div>
				</div>
				<div class="tab-pane" id="articleMetaData">
					<div class="form-group">
						<label for="summary">Summary</label>
						<textarea name="summary" placeholder="Article Summary" class="form-control" rows="3">#((structKeyExists(RC,"summary"))?RC.summary:"")#</textarea>
					</div>
					<div class="form-group">
						<label for="publicationDate">Publication Date</label>
						<input type="text" class="form-control" name="publicationDate" placeholder="#dateFormat(now(),"yyyy/mm/dd")#" data-datepicker='' value="#((structKeyExists(RC,"publicationDate"))?dateFormat(RC.publicationDate,"yyyy/mm/dd"):dateFormat(now(),"yyyy/mm/dd"))#" />
					</div>
					<div class="form-group">
						<label for="articleTags">Tags</label>
						<input type="text" class="form-control" name="articleTags" placeholder="Article Tags" value="#((structKeyExists(RC,"articleTags"))?RC.articleTags:"")#" />
					</div>
				</div>
			</div>

			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</section>
	<section class='col-sm-6' id='articlePreview'>
		<cfif structKeyExists(RC,"article") AND isObject(RC.article)>
			#view('blog/view')#
		</cfif>
	</section>
</cfoutput>
