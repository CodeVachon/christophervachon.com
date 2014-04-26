<cfscript>
	param name="RC.post" default=structNew();

	//writeDump(RC.post);

	LOCAL.body = "Unknown Feed Type";
	if (structKeyExists(RC.post,"story")) {
		LOCAL.body = RC.post.story;
	} else if (structKeyExists(RC.post,"message")) {
		LOCAL.body = RC.post.message;
	} 

	if (structKeyExists(RC.post,"story_tags")) {
		for (LOCAL.key in RC.post.story_tags) {
			for (LOCAL.thisTag in RC.post.story_tags[LOCAL.key]) {
				LOCAL.tagDetails = APPLICATION.socialMedia.getFacebookUserDetails(LOCAL.thisTag.id);
				if (structKeyExists(LOCAL.tagDetails,"link")) {
					LOCAL.body = reReplaceNoCase(LOCAL.body,"(#LOCAL.tagDetails.name#)","<a href='#LOCAL.tagDetails.link#' target='_blank'>\1</a>","ALL");
				}
			}
		}
	}


	LOCAL.userDetails = APPLICATION.socialMedia.getFacebookUserDetails(RC.post.from.id);
</cfscript>
<cfoutput>
	<article class='wall-item media facebookPost'>
		<cfif structKeyExists(LOCAL.userDetails,"link")><a href='#LOCAL.userDetails.link#' class='pull-left' target='_blank'></cfif>
			<img src='#LOCAL.userDetails.picture.data.url#' class='media-object<cfif NOT structKeyExists(LOCAL.userDetails,"link")> pull-left</cfif>' />
		<cfif structKeyExists(LOCAL.userDetails,"link")></a></cfif>
		<div class='media-body'>
			<header class='media-heading'>
				<span class='pull-right post-date'>#DateFormat(APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_time), "MMM d, YYYY")#</span>
				<cfif structKeyExists(LOCAL.userDetails,"link")><a href='#LOCAL.userDetails.link#' target='_blank'></cfif>
				#LOCAL.userDetails.name#
				<cfif structKeyExists(LOCAL.userDetails,"link")></a></cfif>
			</header>
			<div class='body'>
				#APPLICATION.socialMedia.formatPostAsHTML(LOCAL.body)#
				
				<cfif structKeyExists(RC.post,"type") AND (RC.post.type EQ "link") AND (NOT structKeyExists(RC.post,"application"))>
					<section class='website'>
						<cfif structKeyExists(RC.post,"picture")>
							<a href='#RC.post.link#' target='_blank' class='pull-left fb-url-image'>
								<img src='#RC.post.picture#' alt='facebook image' class='img-responsive img-thumbnail' />
							</a>
						</cfif>
						<cfif structKeyExists(RC.post,"name")><p class='title'>#RC.post.name#</p></cfif>
						<cfif structKeyExists(RC.post,"description")><p>#RC.post.description#</p></cfif>
					</section>
				<cfelseif structKeyExists(RC.post,"picture")>
					<cfif structKeyExists(RC.post,"link")><a href='#RC.post.link#' target='_blank'<cfif structKeyExists(RC.post,"name") OR structKeyExists(RC.post,"description")> class='pull-left fb-url-image'</cfif>></cfif>
					<img src='#RC.post.picture#' alt='facebook image' class='img-responsive img-thumbnail' />
					<cfif structKeyExists(RC.post,"link")></a></cfif>
				</cfif>
			</div>
			<footer>
				<cfif structKeyExists(RC.post,"actions")>
					<ul class='pull-right list-unstyled list-inline'>
						<cfloop array="#RC.post.actions#" index="LOCAL.action">
							<li><a href='#LOCAL.action.link#' target='_blank'>#LOCAL.action.name#</a></li>
						</cfloop>
					</ul>
				</cfif>
			</footer>
			<cfif structKeyExists(RC.post,"comments")>
				<section class='comments'>
					<p class='title'>Comments</p>
					<cfset LOCAL.commentsArray = RC.post.comments.data />
					<cfloop array="#LOCAL.commentsArray#" index="RC.post">
						#view("main/socialMedia/facebook/post")#
					</cfloop>
				</section>
			</cfif>
		</div>
	</article>
</cfoutput>