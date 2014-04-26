<cfoutput>
	<article class='wall-item media twitterPost'>
		<a href='https://twitter.com/#RC.post.user.screen_name#' class='pull-left' target='_blank'><img src='#RC.post.user.profile_image_url#' class='media-object' /></a>
		<div class='media-body'>
			<header class='media-heading'>
				<span class='pull-right post-date'>#DateFormat(APPLICATION.socialMedia.convertTimeStampToDateTime(RC.post.created_at), "MMM d, YYYY")#</span>
				#RC.post.user.name#
				<a href='https://twitter.com/#RC.post.user.screen_name#' target='_blank' class='screen-name'>@#RC.post.user.screen_name#</a>
			</header>
			<div class='body'>
				#APPLICATION.socialMedia.formatPostAsHTML(RC.post.text)#
				<cfif structKeyExists(RC.post,"entities")>
					<section class='media'>
						<cfif structKeyExists(RC.post.entities, "media")>
							<cfloop array="#RC.post.entities.media#" index="LOCAL.imgDetails">
								<cfif LOCAL.imgDetails.type EQ "photo">
									<img src='#LOCAL.imgDetails.media_url#' alt='tweeted image' class='img-responsive img-thumbnail' />
								</cfif>
							</cfloop>
						</cfif>
					</section>
				</cfif>
			</div>
			<footer>
				<ul class='pull-right list-unstyled list-inline'>
					<li><a href="https://twitter.com/intent/tweet?in_reply_to=#RC.post.id_str#" class='tw-reply' title='Reply to #RC.post.user.name#'><span class='hidden-md hidden-sm'>Reply</span></a></li>
					<li><a href="https://twitter.com/intent/retweet?tweet_id=#RC.post.id_str#" class='tw-retweet' title='Retweet this Post'><span class='hidden-md hidden-sm'>Retweet</span></a></li>
					<li><a href="https://twitter.com/intent/favorite?tweet_id=#RC.post.id_str#" class='tw-favorite' title='Favorite this Post'><span class='hidden-md hidden-sm'>Favorite</span></a></li>
				</ul>
				<span class='label label-primary'>#RC.post.retweet_count# Retweets</span>
			</footer>
		</div>
	</article>
</cfoutput>
