<cfoutput>
	<div class='panel panel-default'>
		<div class='panel-heading'>
			<h3 class="panel-title">Me in Social Media</h3>
		</div>
		<form class='panel-body' method="get" action='#buildURL('blog.search')#'>
			<div class="input-group">


				<ul class='nav nav-tabs nav-justified'>
					<li class="active"><a href='##aboutMe-twitter' data-toggle="tab">Twitter</a></li>
					<li><a href='##aboutMe-facebook' data-toggle="tab">Facebook</a></li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane active" id="aboutMe-twitter">
						Twitter
					</div>
					<div class="tab-pane" id="aboutMe-facebook">
						Facebook
					</div>
				</div>

			</div>
		</form>
	</div>
</cfoutput>