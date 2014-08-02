<cfoutput>
	<script src="https://sdk.amazonaws.com/js/aws-sdk-2.0.11.min.js"></script>
	<script>
		AWS.config.update({accessKeyId: '#APPLICATION.websiteSettings.getProperty("AWS_accessKey")#', secretAccessKey: '#APPLICATION.websiteSettings.getProperty("AWS_secret")#'});
		AWS.config.region = 'us-east-1';
	</script>
</cfoutput>
