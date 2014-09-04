<nav class="navbar navbar-inverse navbar-global" role="navigation">
    <div class="container">
        

        <div class="navbar-header">
            <div class="navbar-brand">
                <a class="logo" href="$BaseHref">
                    <% include BrandSvg %>
                    <span>SilverStripe</span>
                </a>
                <h1 class="visible-xs">$CurrentPage.Title</h1>
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
        <ul id="loader-menu" class="nav navbar-nav global-right pull-right">
            <li><span class="icon icon-sm ion-ios7-reloading"></span></li>
        </ul>
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
					<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
					<% if $Children %>
					<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu">
						<% loop Children %>
						<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
							<% if $Children %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios7-arrow-down"></span><% end_if %>
							<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
							<% if $Children %>
							<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu"> 
								<% loop Children %>
								<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
									<% if $Children %><span data-toggle="collapse" data-target="#nav-{$ID}" class="icon ion-ios7-arrow-down"></span><% end_if %>
									<a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML<% if $Children %><% else %><span class="icon ion-ios7-arrow-right"></span><% end_if %></a>
									<% if $Children %>
									<ul class="collapse list-unstyled" id="nav-{$ID}" role="menu">
										<% loop Children %>
										<li class="$LinkingMode sub-nav<% if $Children %> children<% end_if %>">
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

<% loop $Pages %>
<% if $ShouldShowChildren %>
<nav class="navbar navbar-inverse navbar-secondary navbar-toolbar" role="navigation" data-parent-id="$ID">
    <div class="container">
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" role="navigation">
                <% loop $GlobalNavChildren %>
                    <li class="">
                        <a data-parent-id="$ParentID" href="$GlobalNavLink" title="Go to the $Title.XML page" class="<% if $HighlightMenu %>btn btn-default <% end_if %>">$MenuTitle.XML</a>
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
var a, parentid, parent;
// Check if an extrenal link in the nav goes to this site
a = document.querySelector('.nav a[data-link="'+window.location.origin+'"]') ||
    document.querySelector('.nav a[data-link="'+window.location.pathname+'"]');

if(!a) return;

a.parentNode.classList.add('current');
if(parent_id = a.getAttribute('data-parent-id')) {        
    if(parent = document.querySelector('[data-id="'+parent_id+'"]')) {            
        parent.classList.add('current');
        var childNav = document.querySelector('nav[data-parent-id="'+parent_id+'"]');            
        document.querySelector('nav[data-parent-id="'+parent_id+'"]').style.display='block';
    }
}

})();

(function() {
    var base = document.getElementsByTagName('base');
    var currentHost = base ? base[0].href : false;
    
    if(currentHost == '$ToolbarHostname') {
        document.getElementById('navWrapper').setAttribute('data-current-host', true);
    }

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
        else console.log('no navsearch a');

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
