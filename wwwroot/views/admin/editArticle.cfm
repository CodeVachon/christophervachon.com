<cfscript>
	if (!structKeyExists(RC,"article") OR !isObject(RC.article)) {
		RC.article = new models.article();
		RC.article.setTitle("New Article");
		RC.article.setSummary("New Article Summary");
		RC.article.setBody("");
	}

	LOCAL.isMarkDown = false;
	if (!structKeyExists(RC,"article")) {
		LOCAL.isMarkDown = true;
	} else if (RC.article.isMarkDownArticle()) {
		LOCAL.isMarkDown = true;
	}

	if (structKeyExists(RC,"title") && LOCAL.isMarkDown) {
		LOCAL.tabMetaDataClass = "";
		LOCAL.tabMarkDownClass = "active";
	} else {
		LOCAL.tabMetaDataClass = "active";
		LOCAL.tabMarkDownClass = "";
	}

	writeOutput(view("admin/amazonS3"));
</cfscript>
<cfoutput>
	<section class='col-sm-6' id='articleForm'>
		<h2>Edit Article</h2>
		<cfif structKeyExists(RC,"validationError")>
			#view('main/validationError')#
		</cfif>

		<form role="form" name="articleForm" method="post" action="/admin/editArticle" id="editorForm">
			<input type='hidden' name="articleId" value="#((structKeyExists(RC,"articleId"))?RC.articleId:"")#">

			<ul class="nav nav-tabs">
				<li class="#LOCAL.tabMetaDataClass#"><a href="##articleMetaData" data-toggle="tab">Meta Data</a></li>
				<cfif LOCAL.isMarkDown><li class="#LOCAL.tabMarkDownClass#"><a href="##articleBody" data-toggle="tab">Mark Down</a></li></cfif>
				<li><a href="##articleBodyHTML" data-toggle="tab">HTML</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane #LOCAL.tabMetaDataClass#" id="articleMetaData">
					<div class="form-group">
						<label for="title">Title</label>
						<input type="text" class="form-control" name="title" placeholder="Article Title" value="#((structKeyExists(RC,"title"))?RC.title:"")#" />
					</div>
					<div class="form-group">
						<label for="summary">Summary</label>
						<textarea name="summary" placeholder="Article Summary" class="form-control frm-summary" rows="3">#((structKeyExists(RC,"summary"))?RC.summary:"")#</textarea>
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
				<cfif LOCAL.isMarkDown>
					<div class="tab-pane #LOCAL.tabMarkDownClass#" id="articleBody">
						<div class="form-group">
							<a href='##' class='pull-right s3-library'><span class='glyphicon glyphicon-picture'></span></a>
							<label for="markdown">Mark Down</label>
							<textarea name="markdown" id="markdown" v-model="input" v-on="keyup: onKeyUp" class="form-control" rows="5">#((structKeyExists(RC,"markdown"))?RC.markdown:"")#</textarea>
						</div>
					</div>
				</cfif>
				<div class="tab-pane" id="articleBodyHTML">
					<div class="form-group">
						<label for="body">HTML</label>
						<textarea name="body" id="body" v-html="input | marked" class="form-control" rows="5"><cfif NOT LOCAL.isMarkDown>#((structKeyExists(RC,"body"))?RC.body:"")#</cfif></textarea>
					</div>
				</div>
			</div>

			<button type="submit" class="btn btn-primary" name='btnSave'>Save</button>
		</form>
	</section>
	<section class='col-sm-6'>
		<div class='pull-right toggleLibraries'>
			<span class='glyphicon glyphicon-tasks'></span><span class='hidden-xs hidden-sm'> Libraries</span>
		</div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="##articlePreview" data-toggle="tab">Article Preview</a></li>
			<li><a href="##summaryPreview" data-toggle="tab">Summary Preview</a></li>
		</ul>
		<div class="tab-content previewPane">
			<div class="tab-pane active" id="articlePreview" v-html="input | marked">
				#view('blog/view')#
			</div>
			<div class="tab-pane" id="summaryPreview">
				#view('blog/summary')#
			</div>
		</div>
	</section>
</cfoutput>
