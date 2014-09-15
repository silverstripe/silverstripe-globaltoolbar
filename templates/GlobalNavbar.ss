<nav class="navbar navbar-inverse navbar-global" role="navigation">
    <div class="container">
        
        <div class="navbar-header">
            <div class="navbar-brand">
                <a class="logo" title="SilverStripe" href="$BaseHref">
                    <% include BrandSvg %>
                </a>
                <h1 class="brand-name">
                    <a title="SilverStripe" href="$BaseHref">
                        <span>Silver</span>Stripe
                    </a>
                </h1>
                <h1 class="page-name">$CurrentPage.MenuTitle</h1>
            </div>

            <a id="nav-expander" class="nav-expander fixed visible-xs navbar-toggle">
                <span class="ion-navicon"></span>
                <span class="sr-only">Toggle navigation</span>
            </a>
        </div>
        
        <%-- Profile menu --%>
        <ul id="profile-menu" class="nav navbar-nav global-right pull-right" style="display:none;">
            
            <li class="nav-search">
                <a class="search" href="#SearchAnchor" title="Search">
                    <% include SearchSvg %>
                    <span>Search site</span>
                </a>
            </li>
            <!-- <li class="hidden-xs">
                <a class="ion-ios7-bell" href="javascript:void(0);" title="Notifications"></a>
            </li> -->
            
            <li>                                
                <iframe id="toolbar-iframe" src="{$ToolbarHostname}/toolbar/profile" frameborder="0" width="0" scrolling="no"></iframe>
            </li>

        </ul>
        <i id="loader-menu" class="loader-profile pull-right icon icon-xs ion-ios7-reloading"></i>
        <%-- Navigation top level --%>
 
        <ul class="nav navbar-nav global-nav hidden-xs" role="navigation">
            <% loop $Pages %>    
                <li data-id="$ID">
                    <a href="$GlobalNavLink" data-link="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a>
                </li>
            <% end_loop %>
        </ul>

		<nav class="slide-menu visible-xs" role="navigation">
			<ul class="nav list-unstyled">
				<li class="text-right"><a href="#" id="nav-close" class="ion-ios7-close-empty"></a></li>
				<li><a href="$ToolbarHostname" title="Go to the Home page">Home</a></li>
				<% loop $Pages %>
				<li class="$LinkingMode<% if $Children %> children<% end_if %>">
					<% if $Children %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios7-arrow-down"></span><% end_if %>
					<a data-link="$Link" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
					<% if $Children %>
					<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu">
						<% loop Children %>
						<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
							<% if $Children %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios7-arrow-down"></span><% end_if %>
							<a data-parent-id="$ParentID" data-link="$Link" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
							<% if $Children %>
							<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu"> 
								<% loop Children %>
								<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
									<% if $Children %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios7-arrow-down"></span><% end_if %>
									<a data-parent-id="$ParentID" data-link="$Link" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
									<% if $Children %>
									<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu">
										<% loop Children %>
										<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
											<a data-parent-id="$ParentID" data-link="$Link" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML</a>
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

<% loop $Pages %>
<% if $ShouldShowChildren %>
<nav class="navbar navbar-inverse navbar-secondary navbar-toolbar" role="navigation" data-parent-id="$ID">
    <div class="container">
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" role="navigation">
                <% loop $GlobalNavChildren %>
                    <li data-id="$ID" class="">
                        <a data-parent-id="$ParentID" data-link="$Link" href="$GlobalNavLink" title="Go to the $Title.XML page" class="<% if $HighlightMenu %>btn btn-default <% end_if %>">$MenuTitle.XML</a>
                    </li>
                <% end_loop %>
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</nav>
<% end_if %>
<% end_loop %>
<script type="text/javascript" src="{$ToolbarHostname}/toolbar/js/iframe-resizer/js/iframeResizer.min.js"></script>
<script type="text/javascript">

(function() {
var a, parent_id, parent, parents, children, base, currentHost, isCurrentHost;
currentHost = '//'+window.location.hostname;
isCurrentHost = (currentHost == '$ToolbarHostname');

// Check if there's a forced state
if(window.GLOBAL_NAV_PRIMARY_ID) {
    a = document.querySelectorAll('li[data-id="'+window.GLOBAL_NAV_PRIMARY_ID+'"] a');
}
else if(window.GLOBAL_NAV_SECONDARY_ID) {   
    a = document.querySelectorAll('.navbar-secondary li[data-id="'+window.GLOBAL_NAV_SECONDARY_ID+'"] a');
}
else {    
    // Check if an extrenal link in the nav goes to this site
    a = document.querySelectorAll('a[data-link="'+window.location.origin+'"]');
    if(!a.length) {
        a = document.querySelectorAll('a[data-link="'+window.location.pathname.replace(/\\/?$/, '/')+'"]');            
    }
}

if(!a.length) {    
    return;
}

[].slice.call(a).forEach(function(link) { 
    if(parent_id = link.getAttribute('data-parent-id')) {         
        link.parentNode.classList.add('active');
        if(parents = document.querySelectorAll('[data-id="'+parent_id+'"]')) {            
            [].slice.call(parents).forEach(function(parent) {
                parent.classList.add('current');
                // ss.org doesn't render a static secondary nav. Uses its own template.
                if(!isCurrentHost) { 
                    children = document.querySelectorAll('nav[data-parent-id="'+parent_id+'"]');
                    [].slice.call(children).forEach(function(child) {
                        child.style.display='block';
                    });
                }
            });
        }
    }
    else {
        link.parentNode.classList.add('current');
    }

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


        function scrollToElement(el, scrollDuration, padding) {
            scrollDuration = scrollDuration || 300;
            padding = padding || 0;

            if(typeof el === "string") {
                el = document.querySelector(selector);
            }
            
            if(!el) return;
            
            var scrollHeight = window.scrollY,
                scrollStep = Math.PI / ( scrollDuration / 15 ),                
                scrollCount = 0,
                scrollMargin,
                scrollStop = Math.floor(el.getBoundingClientRect().top + document.body.scrollTop + padding),
                cosParameter = Math.abs(scrollStop-scrollHeight) / 2,
                direction = scrollStop > scrollHeight ? 1 : -1;
            
            requestAnimationFrame(step);        
        
            function step () {                
                setTimeout(function() {
                    var nextY;                    
                    scrollCount = scrollCount + 1;  
                    scrollMargin = cosParameter - cosParameter * Math.cos( scrollCount * scrollStep );
                    nextY = Math.round(scrollHeight + (scrollMargin * direction));                     
                    if(nextY === scrollStop) return;
                    if(direction > 0 && nextY > scrollStop) return;
                    if(direction < 0 && nextY < scrollStop) return;

                    requestAnimationFrame(step);
                    window.scrollTo( 0, nextY );
                }, 15 );
            }
        }

        setTimeout(function() {
            document.getElementById('profile-menu').style.display='block';
            document.getElementById('loader-menu').style.display='none';
        }, 600);


        function desktopClose(elem) {
            searchClose.addEventListener('click', function (e) {
                e.preventDefault();
                elem.classList.remove('show');
            });
        }

        // search tabs
        if(navSearchA) {
            navSearchA.addEventListener('click', function (e) {
                e.preventDefault();
                e.target.parentNode.classList.add('current');
                desktopSearchElem.classList.add('show');                
                scrollToElement(desktopSearchElem, 300, 0);                
                if(desktopSearchElem.classList.contains('show')) {
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

</script>
