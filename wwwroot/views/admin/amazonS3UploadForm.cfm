<cfscript>
	LOCAL.s3Info = {
		bucketName = "christophervachon",
		acl = "public-read",
		key = "articles/#year(now())#/#month(now())#/${filename}",
		success_action_redirect = CGI.SERVER_NAME,
		ContentType = "image/jpeg"
	};

	LOCAL.policyRaw = {
		"expiration": "#dateFormat(DateAdd("d",2,now()),"YYYY-MM-DD")#T12:00:00.00Z",
		"conditions": [
			{"bucket": "#LOCAL.s3Info.bucketName#"},
			{"acl": "#LOCAL.s3Info.acl#" },
 			{"success_action_redirect": "#LOCAL.s3Info.success_action_redirect#"},
			["starts-with", "$key", "#left(LOCAL.s3Info.key,3)#"]
		]
	};

	serializedPolicy = serializeJson( LOCAL.policyRaw );
	serializedPolicy = reReplace( serializedPolicy, "[\r\n]+", "", "all" );
	encodedPolicy = binaryEncode(charsetDecode( serializedPolicy, "utf-8" ), "base64");

	hashedPolicy = hmac(
		encodedPolicy,
		APPLICATION.websiteSettings.getProperty("AWS_secret"),
		"HmacSHA1",
		"utf-8"
	);

	encodedSignature = binaryEncode(
		binaryDecode( hashedPolicy, "hex" ),
		"base64"
	);
</cfscript>
<cfoutput>
	<div class='amazonS3-upload-form'>
		<form action="https://#LOCAL.s3Info.bucketName#.s3.amazonaws.com/" method="post" enctype="multipart/form-data">
			<input type="hidden" name="AWSAccessKeyId" value="#trim(APPLICATION.websiteSettings.getProperty("AWS_accessKey"))#" />
			<input type="hidden" name="signature" value="#encodedSignature#" />
			<input type="hidden" name="acl" value="#LOCAL.s3Info.acl#" />
			<input type="hidden" name="key" value="#LOCAL.s3Info.key#" />
			<input type="hidden" name="policy" value="#encodedPolicy#" />
			<input type="hidden" name="success_action_redirect" value="#LOCAL.s3Info.success_action_redirect#" />
			<input type="file" name="file" />
			<input type="submit" value="Upload" class='btn btn-primary' />
		</form>
	</div>
</cfoutput>
