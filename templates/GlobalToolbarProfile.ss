<!doctype html>
<!--[if lt IE 7 ]><html lang="en" class="ie ie6"><![endif]-->
<!--[if IE 7 ]>   <html lang="en" class="ie ie7"><![endif]-->
<!--[if IE 8 ]>   <html lang="en" class="ie ie8"><![endif]-->
<!--[if !IE]> --> <html lang="en">               <!-- <![endif]-->
<head>
	<base target="_parent" />
	<link rel="icon" type="image/png" href="favicon.png">
	<link rel="search" type="application/opensearchdescription+xml" title="SilverStripe.org (Search)" href="{$AbsoluteBaseUrl}/search/description">
	<style>
		body {
		    margin-top: 13px;
		    padding: 0;
		    color: #fff;
		    max-width: 82px;
		    width: auto;
		    overflow: hidden;
		}
		a.profile,
		a.logout,
		a.login {	
			display: inline-block;
			width: 24px;
			height: 24px;
			vertical-align: middle;
		}
		a.profile {
			width: 22px;
			height: 22px;
			border-radius: 11px;
			overflow: hidden;
			margin-right: 12px;
		}
		a.login img {
			margin-top: -3px;
		}

		/* Todo: color change on hover */
		/*a.logout .colorchange,
		a.login  .colorchange {
			fill: #2F718A;
		}
		a.logout .colorchange:hover,
		a.login  .colorchange:hover {
			fill: #42C6F3;
		}*/
	</style>
</head>

<body>
<% if CurrentMember %>
	<a href="{$BaseHref}ForumMemberProfile/show/$CurrentMember.ID" class="profile" title="$CurrentMember.Nickname profile">$CurrentMember.Avatar.CroppedImage(22,22)</a>

	<!-- <a target="_parent" href="{$BaseHref}Security/logout" class="logout"><img width="24" height="24" alt="Logout" src="../$ThemeDir/img/icons/log-out.svg"></a> -->

<% else %>
	<a class="login" href="{$BaseHref}Security/login" title="Login">
		<img width="26" height="26" class="login" alt="Login" src="../$ThemeDir/img/icons/ios7-contact-outline.svg">
	</a>
	<!-- <a href="{$BaseHref}Security/login" class="login"><span></span>Login</a>
	<a href="{$BaseHref}ForumMemberProfile/register">Register</a> -->
<% end_if %>
<script>
	if(document.querySelector('a.logout'))parent.document.getElementById('toolbar-iframe').width = 80;	
</script>
</body>
</html>