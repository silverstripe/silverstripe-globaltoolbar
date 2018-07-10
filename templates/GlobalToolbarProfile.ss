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
		    padding: 0;
		    margin: 0;
		    color: #fff;
		    max-width: 120px;
		    width: auto;
		    overflow: hidden;
		}
		a.profile,
		a.logout,
		a.login {	
			display: inline-block;
			width: 30px;
			height: 30px;
			vertical-align: top;
		}
		a.profile {
			width: 40px;
			height: 40px;
			border-radius: 50%;
			overflow: hidden;
			margin: 10px 0 10px 14px;
			float: left;
			background-color: #e6e6e6;
			-webkit-transition: all ease-in-out .1s;
			-o-transition: all ease-in-out .1s;
			transition: all ease-in-out .1s;
		}
		a.profile img {
			width: 100%;
		}
		a.profile:hover {
			transform: scale(1.1);
		}
		a.login {
			padding: 13px 14px;
			opacity: 0.8;
		}
		a.login:hover {
			opacity: 1;
		}
		a.logout {
			padding: 15px 12px;
			opacity: 0.8;
		}
		a.logout:hover {
			opacity: 1;
		}

		/* Mobile only - login and logout states */
		.toolbar-iframe-mobile a.login .profile-login {
			fill: #9ea8b2;
		}
		.toolbar-iframe-mobile a.login:hover .profile-login {
			fill: #fff;
		}

		/* No profile avatar state */
		.toolbar-iframe-mobile a.profile .profile-login {
			fill: #9ea8b2;
		}

		.toolbar-iframe-mobile a.logout .profile-logout {
			fill: #9ea8b2;
		}
		.toolbar-iframe-mobile a.logout:hover .profile-logout {
			fill: #fff;
		}

		img.default-avatar {
			padding: 4px 0;
		}
	</style>
</head>

<body>
<% if CurrentMember %>
	<a href="{$BaseHref}ForumMemberProfile/show/$CurrentMember.ID" class="profile" title="$CurrentMember.Nickname profile">
	<% if $CurrentMember.Avatar %>$CurrentMember.Avatar.CroppedImage(34,34)<% else %><% include ProfileSvg %><% end_if %>
	</a>
	<a class="logout" id="logout" href="{$BaseHref}Security/logout" target="_parent">
		<% include LogoutSvg %>
	</a>
<% else %>
	<a class="login" id="login" href="{$BaseHref}Security/login" title="Login">
		<% include ProfileSvg %>
	</a>
<% end_if %>
<script src="js/iframe-resizer/js/iframeResizer.contentWindow.min.js"></script>
<script>
<% if $CurrentMember %>var w=108;<% else %>var w=58;<% end_if %>
document.addEventListener('DOMContentLoaded', function(){
	var interval = window.setInterval(function() {
		if('parentIFrame' in window) {
			parentIFrame.size(60, w);
			window.clearInterval(interval);

			<%-- Add Iframe ID's as classes to global toolbar body to target 
			mobile/desktop versions separately --%>
			document.body.classList.add(parentIFrame.getId());
		}
	}, 100);
});

 var a = document.getElementById('logout');
 if(a) {
	 var href = a.getAttribute('href');
	 try {
	 	href += "?BackURL=" + window.parent.location.pathname;
	 	if(window.parent.location.search) {
	 		href += encodeURIComponent(window.parent.location.search);
	 	}
	 	a.setAttribute('href', href);
	 } catch(e) {
	 	href += "?BackURL=/";
	 	a.setAttribute('href', href);
	 }
 }

</script>
</body>
</html>