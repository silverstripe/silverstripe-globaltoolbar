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
		a.profile img.login {
			opacity: 0.7;
		}
		a.profile img.login:hover {
			opacity: 1;
		}
		a.profile:hover {
			transform: scale(1.1);
		}
		a.login {
			padding: 13px 14px;
			opacity: 0.7;
		}
			a.login:hover {
				opacity: 1;
			}
		img.login {
			border: 0px;
		}
		a.logout {
			opacity: 0.7;
			padding: 15px 12px;
		}
		a.logout:hover {
			opacity: 1;
		}
		img.default-avatar {
			padding: 4px 0;
		}
	</style>
</head>

<body>
<% if $CurrentMember %>
	<a href="{$BaseHref}ForumMemberProfile/show/$CurrentMember.ID" class="profile" title="$CurrentMember.Nickname profile">
	<% if $CurrentMember.Avatar %>$CurrentMember.Avatar.CroppedImage(34,34)<% else %><img width="30" height="30" class="login default-avatar" alt="Login" src="../$ThemeDir/img/icons/ios7-contact-outline.svg"><% end_if %>
	</a>
	<a id="logout" target="_parent" href="{$BaseHref}Security/logout" class="logout"><img width="30" height="30" alt="Logout" src="../$ThemeDir/img/icons/log-out.svg"></a>
<% else %>
	<a class="login" id="login" href="{$BaseHref}Security/login" title="Login">
		<img width="30" height="30" class="login" alt="Login" src="../$ThemeDir/img/icons/ios7-contact-outline.svg">
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
