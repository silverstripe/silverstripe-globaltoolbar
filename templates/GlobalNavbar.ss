<nav class="navbar navbar-global" role="navigation" id="NavbarGlobal">
	<div class="container-fluid">
		<div class="navbar-header">

			<a class="navbar-menu js-nav-trigger hidden-xs hidden-sm">
				<span class="sr-only">Site Navigation</span>
				<span class="icon ion-navicon-round"></span>
			</a>

			<div class="navbar-brand">
				<h1 class="brand-name">
					<a class="logo" title="SilverStripe" href="$Scope.Level(1).Link">
						<img class="global-logo" src="{$ToolbarHostname}/themes/ssv3/img/global-logo-<% if $Scope.Level(1) %>{$Scope.Level(1).URLSegment}<% else %>open-source<% end_if %>.svg" alt="{$Scope.Menu(1).Title}">
					</a>
				</h1>
			</div>

			<a class="js-nav-expander navbar-menu nav-expander fixed visible-xs visible-sm">
				<span class="icon ion-navicon-round"></span>
				<span class="sr-only">Mobile site navigation</span>
			</a>
		</div>

		<%-- Profile menu --%>
		<ul id="profile-menu" class="nav navbar-nav global-right pull-right" style="display:none;">
			<li class="nav-search">
				<a class="search" href="javascript:void(0)" title="Search">
					<% include SearchSvg %>
					<span class="sr-only">Search site</span>
				</a>
			</li>

			<li class="hidden-xs hidden-sm">
				<iframe id="toolbar-iframe" src="{$ToolbarHostname}/toolbar/profile" frameborder="0" width="0" scrolling="no"></iframe>
			</li>
		</ul>
		<i id="loader-menu" class="loader-profile pull-right icon icon-xs ion-ios-reloading"></i>
		<%-- Navigation top level --%>
		<ul class="nav navbar-nav global-nav hidden-xs hidden-sm" role="navigation">						
			<% loop $Scope.Menu(2) %><li class="dropdown-hover <% if $Top.ActivePage.ID == $ID %>current<% else_if $Top.ActivePage.InNode($ID) %>section<% end_if %>"><a href="$GlobalNavLink" title="Go to the $Title.XML page" class="dropdown-toggle">$MenuTitle.XML</a><% include GlobalNav_secondary_pages ActivePageID=$Top.ActivePage.ID, ActiveParentID=$Top.ActivePage.ParentID, Pages=$GlobalNavChildren %></li><% end_loop %>
		</ul>

		<nav class="slide-menu visible-xs visible-sm" role="navigation">
			<ul class="nav">
				<li class="mobile-nav-login pull-left">
					<iframe id="toolbar-iframe-mobile" src="{$ToolbarHostname}/toolbar/profile" frameborder="0" width="0" scrolling="no"></iframe>
				</li>
				<li class="text-right"><a id="nav-close" class="ion-ios-close-empty"></a></li>
				<% loop $Scope.Menu(1) %>
				<li class="$LinkingMode<% if $GlobalNavChildren %> children<% end_if %><% if $Top.ActivePage.ID == $ID %> current<% else_if $Top.ActivePage.ParentID == $ID %> section<% end_if %>">
					<% if $GlobalNavChildren %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios-arrow-down"></span><% end_if %>
					<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $GlobalNavChildren %><% else %><span class="icon ion-ios-arrow-right"></span><% end_if %></a>
					<% if $GlobalNavChildren %>
					<ul class="<% if $Top.ActivePage.ID == $ID || $Top.ActivePage.ParentID == $ID %> collapsed in<% else %> collapse<% end_if %> list-unstyled" id="nav-{$ID}" role="menu">
						<% loop Children %>
						<li class="$LinkingMode sub-nav<% if $GlobalNavChildren %> children<% end_if %><% if $Top.ActivePage.ID == $ID %> current<% else_if $Top.ActivePage.ParentID == $ID %> section<% end_if %>">
							<% if $GlobalNavChildren %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios-arrow-down"></span><% end_if %>
							<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $GlobalNavChildren %><% else %><span class="icon ion-ios-arrow-right"></span><% end_if %></a>
							<% if $GlobalNavChildren %>
							<ul class="<% if $Top.ActivePage.ID == $ID || $Top.ActivePage.ParentID == $ID %> collapsed in<% else %> collapse<% end_if %> list-unstyled" id="nav-{$ID}" role="menu">
								<% loop Children %>
								<li class="$LinkingMode sub-nav<% if $GlobalNavChildren %> children<% end_if %><% if $Top.ActivePage.ID == $ID %> current<% else_if $Top.ActivePage.ParentID == $ID %> section<% end_if %>">
									<% if $GlobalNavChildren %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios-arrow-down"></span><% end_if %>
									<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $GlobalNavChildren %><% else %><span class="icon ion-ios-arrow-right"></span><% end_if %></a>
									<% if $GlobalNavChildren %>
									<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu">
										<% loop Children %>
										<li class="$LinkingMode sub-nav<% if $GlobalNavChildren %> children<% end_if %><% if $Top.ActivePage.ID == $ID %> current<% else_if $Top.ActivePage.ParentID == $ID %> section<% end_if %>">
											<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML</a>
										</li>
										<% end_loop %>
									</ul>
									<% end_if %>
								</li>
								<% end_loop %>
							</ul>
							<% end_if %>
						</li>
						<% end_loop %>
					</ul>
					<% end_if %>
				</li>
				<% end_loop %>
			</ul>
		</nav>
	</div>
</nav>

<%-- Mega nav popup --%>
<% include GlobalNav_popup %>

<script type="text/javascript" src="{$ToolbarHostname}/toolbar/js/iframe-resizer/js/iframeResizer.min.js"></script>
<script type="text/javascript">

(function() {
	// Define some utility functions - we can't use jQuery, from http://youmightnotneedjquery.com/.
	function elHasClass(el, className) {
		if (el.classList) {
			return el.classList.contains(className);
		} else {
			return new RegExp('(^| )' + className + '( |$)', 'gi').test(el.className);
		}
	}

	function elAddClass(el, className) {
		if (el.classList) {
			el.classList.add(className);
		} else {
			el.className += ' ' + className;
		}
	}

	function elRemoveClass(el, kls) {
		if (el.classList) {
			el.classList.remove(kls);
		} else {
			el.className = el.className.replace(' ' + kls, '');
		}
	}

	function elToggleClass(el, className) {		
		if(el.classList) {
			el.classList.toggle(className);
		} else if (elHasClass(el, className)) {		
			elRemoveClass(el, className);
		} else {			
			elAddClass(el, className);
		}
	}

	(function() {		
	    var MQL = 1170;
	    var q = function (sel) {
	    	return document.querySelector(sel);
	    };
	    //primary navigation slide-in effect for pop out mega navigation
	    if(window.innerWidth > MQL) {
	        var headerHeight = q('.site-header').offsetHeight;
	        window.addEventListener('scroll', function () {
	            var currentTop = window.scrollTop;
	            //check if user is scrolling up
	            if (currentTop < this.previousTop ) {
	                //if scrolling up...
	                if (currentTop > 0 && elHasClass(q('.site-header'),'is-fixed')) {
	                    elAddClass(q('.site-header'),'is-visible');
	                } else {
	                    elRemoveClass(q('.site-header'),'is-visible is-fixed');
	                }
	            } else {
	                //if scrolling down...
	                elRemoveClass(q('.site-header'),'is-visible');
	                if( currentTop > headerHeight && !elHasClass(q('.site-header'),'is-fixed')) {
	                	elAddClass(q('.site-header'),'is-fixed');
	                }
	            }
	            this.previousTop = currentTop;
	        });
	    }	    

	    //open/close primary pop out mega navigation
	    var triggers = document.querySelectorAll('.js-nav-trigger');
	    [].forEach.call(triggers, function (node) {	 	    
		    node.addEventListener('click', function() {
		        elToggleClass(q('.site-header'), 'menu-is-open');
		        elToggleClass(q('.popup-primary-nav'),'open');		        
		    });

	    })
	})();

	(function() {
		document.addEventListener('DOMContentLoaded', function () {
			var tabHolderElem = document.querySelector('.search-pane');
			var desktopSearchElem = document.getElementById('desktopSearch');
			var navSearchA = document.querySelector('.nav-search a');
			var searchClose = document.querySelector('a.search-close');

			iFrameResize({
				enablePublicMethods: true,
				sizeWidth: true,
				autoResize: false,
				log: false
			}, '#toolbar-iframe');

			iFrameResize({
				enablePublicMethods: true,
				sizeWidth: true,
				autoResize: false,
				log: false
			}, '#toolbar-iframe-mobile');


			function scrollToElement(el, scrollDuration, padding) {
				scrollDuration = scrollDuration || 300;
				padding = padding || 0;

				if(typeof el === "string") {
					el = document.querySelector(selector);
				}

				if(!el) return;

				var interval = 10;
				requestAnimationFrame(step);

				function step () {
					setTimeout(function() {
						if(scrollDuration < 1) {
							return;
						}
						var scrollPos = window.scrollY,
							offset = el.getBoundingClientRect().top,
							togo = offset - padding,
							clicksRemaining = scrollDuration/interval,
							stepSize = togo/clicksRemaining;

						if(Math.round(window.scrollY)  == padding) {
							return;
						}
						if(offset - stepSize < padding) {
							stepSize = offset - padding;
						}

						nextY = scrollPos+stepSize;
						window.scrollTo( 0, nextY );

						scrollDuration -= interval;

						requestAnimationFrame(step);
					}, interval );
				}
			}

			setTimeout(function() {
				document.getElementById('profile-menu').style.display='block';
				document.getElementById('loader-menu').style.display='none';
			}, 1000);


			function desktopClose(elem) {
				searchClose.addEventListener('click', function (e) {
					e.preventDefault();
					elRemoveClass(elem, 'show');
				});
			}

			// search tabs
			if(navSearchA) {
				navSearchA.addEventListener('click', function (e) {
					e.preventDefault();
					elAddClass(e.target.parentNode, 'current');
					elAddClass(desktopSearchElem, 'show');
					if(elHasClass(document.body, 'top-level')) {
						scrollToElement(desktopSearchElem, 200, 65);
					}
					if(elHasClass(desktopSearchElem, 'show')) {
						var searchBox = document.querySelector('input.gsc-input');
						setTimeout(function() {
							event = document.createEvent('HTMLEvents');
							event.initEvent('focus', true, false);
							searchBox.dispatchEvent(event);
						}, 10);
						desktopClose(desktopSearchElem);
					}
				});
			}

		});

	})();
	
	(function() {
		var interval = window.setInterval(function() {
			for(var i=1;i<=3;i++) {
				if(document.getElementById('gsc-i-id'+i)) {
					window.clearInterval(interval);
					document.getElementById('gsc-i-id'+i).setAttribute('placeholder', 'Search SilverStripe...');
				}

			}
		}.bind(this), 500);
	})();

	(function() {
		var cx = '$GoogleCustomSearchId';
		var gcse = document.createElement('script'); gcse.type = 'text/javascript'; gcse.async = true;
		gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
			'//www.google.com/cse/cse.js?cx=' + cx;
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(gcse, s);
	})();

})();

</script>
