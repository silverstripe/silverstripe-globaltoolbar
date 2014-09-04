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
			vertical-align: top;
		}

		a.profile {
			width: 28px;
			height: 28px;
			border-radius: 50%;
			overflow: hidden;
			margin: 11px 11px 0 5px;	

			-webkit-transition: all ease-in-out .1s;
       		-o-transition: all ease-in-out .1s;
          	transition: all ease-in-out .1s;
		}
			a.profile img {
				width: 100%;
			}
			a.profile:hover {
				width: 30px;
				height: 30px;
				margin: 10px 10px 0 4px;
			}

		a.login {
			margin-top: 10px;
			margin-left: 12px;
			opacity: 0.7;
		}
			a.login:hover {
				opacity: 1;
			}

		a.logout {
			opacity: 0.7;
			margin-top: 12px;
		}
			a.logout:hover {
				opacity: 1;
			}
	</style>
</head>

<body>
<% if CurrentMember %>
	<a href="{$BaseHref}ForumMemberProfile/show/$CurrentMember.ID" class="profile" title="$CurrentMember.Nickname profile">
	<% if $CurrentMember.Avatar %>$CurrentMember.Avatar.CroppedImage(34,34)<% else %><img width="26" height="26" class="login" alt="Login" src="../$ThemeDir/img/icons/ios7-contact-outline.svg"><% end_if %>
	</a>
	<a id="logout" target="_parent" href="{$BaseHref}Security/logout" class="logout"><img width="24" height="24" alt="Logout" src="../$ThemeDir/img/icons/log-out.svg"></a>
<% else %>
	<a class="login" id="login" href="{$BaseHref}Security/login" title="Login">
		<img width="26" height="26" class="login" alt="Login" src="../$ThemeDir/img/icons/ios7-contact-outline.svg">
	</a>
<% end_if %>
<script src="js/iframe-resizer/js/iframeResizer.contentWindow.min.js"></script>
<script>
<% if $CurrentMember %>var w=80;<% else %>var w=40;<% end_if %>
document.addEventListener('DOMContentLoaded', function(){
	window.setTimeout(function() {
		parentIFrame.size(39, w);		
	}, 500);
});

 var a = document.getElementById('logout');
 if(a) {
	 var href = a.getAttribute('href');
	 try {
	 	href += "?BackURL=" + window.parent.location.pathname;
	 	a.setAttribute('href', href);
	 } catch(e) {
	 	href += "?BackURL=/";
	 	a.setAttribute('href', href);
	 }
 }

</script>
</body>
</html>