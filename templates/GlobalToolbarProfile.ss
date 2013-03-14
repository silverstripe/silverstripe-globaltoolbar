<html>
  <head>
		<base target="_parent" />
		<link rel="icon" type="image/png" href="favicon.png">
		<link rel="search" type="application/opensearchdescription+xml" title="SilverStripe.org (Search)" href="{$AbsoluteBaseUrl}/search/description">
	</head>
	
	<body class="ss-globaltoolbar ss-globaltoolbar-iframe">
		<div class="ss-globaltoolbar-login">
			<% if CurrentMember %>
				Welcome <a href="/ForumMemberProfile/$CurrentMember.ID">$CurrentMember.Nickname</a> |
				<a href="{$BaseHref}Security/logout">Logout</a> 
			<% else %>
				<a href="{$BaseHref}Security/login">Login</a> |
				<a href="{$BaseHref}ForumMemberProfile/register">Register</a>
			<% end_if %>
		</div>
	</body>
</html>
