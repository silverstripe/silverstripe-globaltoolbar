<div id="navWrapper">
    <nav class="navbar navbar-inverse navbar-global" role="navigation">
        <div class="container">
            <h1 class="visible-xs">$Title</h1>

            <%-- Brand and toggle get grouped for better mobile display --%>
            <div class="navbar-header">
                <div class="navbar-brand">
                    <a class="logo" href="$BaseHref">
                        <% include BrandSvg %>
                        <span>SilverStripe</span>
                    </a>
                </div>

                <a class="navbar-toggle collapsed visible-xs" href="javascript:void(0);" title="Close" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="ion-navicon"></span>
                </a>
            </div>
            
            <%-- Profile menu --%>
            <ul class="nav navbar-nav global-right hidden-xs">
                <li class="nav-search">
                    <a class="search" href="#NavbarSecondary" title="Search">
                        <% include SearchSvg %>
                        <span>Search site</span>
                    </a>
                </li>
                <!-- <li class="hidden-xs">
                    <a class="ion-ios7-bell" href="javascript:void(0);" title="Notifications"></a>
                </li> -->
                <li class="hidden-xs">                
                    <iframe id="toolbar-iframe" src="{$ToolbarHostname}/toolbar/profile" width="40" height="40" frameborder="0" border="0"></iframe>
                </li>
            </ul>

            <%-- Navigation top level --%>
            <ul class="nav navbar-nav global-nav hidden-xs" role="navigation">
                <% loop $Pages %>    
                    <li data-id="$ID">
                        <a href="$GlobalNavLink" data-link="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a>
                    </li>
                <% end_loop %>
            </ul>

            <% include Header_MobileNavigation ToolbarHostname=$ToolbarHostname, Pages=$Pages %>
        </div>
    </nav>

    <% loop $Pages %>
    <% if $ShouldShowChildren %>
    <nav style="display:none;" class="navbar navbar-inverse navbar-secondary" role="navigation" data-parent-id="$ID">
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


    <div class="container">
        <div class="search-pane search-pane-desktop" id="toolbarSearch">
            <a href="#" class="search-close" title="Close search">
                <% include CloseSvg %>
            </a>
            <gcse:searchbox-only resultsUrl="{$BaseUrl}search/" enableAutoComplete="true" title="Search SilverStripe" placeholder="Search SilverStripe"></gcse:searchbox-only>
        </div>
    </div>

</div>

<script type="text/javascript">
(function() {

var parentid, parent;
a = document.querySelector('.nav a[data-link="'+window.location.pathname+'"]');
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
    var currentHost = document.getElementsByTagName('base')[0].href;
    
    if(currentHost == '$ToolbarHostname') {
        document.getElementById('navWrapper').setAttribute('data-current-host', true);
    }

    document.addEventListener('DOMContentLoaded', function () {

        var tabHolderElem = document.querySelector('.search-pane');
        var desktopSearchElem = (currentHost == '$ToolbarHostname') ? 
            document.getElementById('desktopSearch') : 
            document.getElementById('toolbarSearch');
        var navSearchA = document.querySelector('.nav-search a');
        var navTabsSearchA = document.querySelector('.nav-tabs-search a');
        var searchInput = document.querySelector('input.gsc-input');

        var desktopClose = function() {
            $('a.search-close').on('click', function () {
                desktopSearchElem.classList.remove('show');
            });
        }
        var focusSearch = function() {
            if( $(desktopSearchElem).hasClass('show')) {
                $(searchInput).find('input.gsc-input').focus().select();
            }
        }

        // search tabs
        if(navSearchA) {
            navSearchA.addEventListener('click', function (e) {
                e.preventDefault();
                e.target.parentNode.classList.add('current');
                desktopSearchElem.classList.add('show', function() {
                    focusSearch();
                });
                desktopClose();
            });
        }
        else console.log('no navsearch a');

        if(navTabsSearchA) {
            navTabsSearchA.addEventListener('click', function (e) {
                e.preventDefault();
                e.target.parentNode.classList.toggle('show');
                tabHolderElem.classList.toggle('show', function() {
                    focusSearch();
                });
                desktopClose();
            });
        }

    });

})();

(function() {
var cx = '$GoogleCustomSearchId';
var gcse = document.createElement('script'); gcse.type = 'text/javascript'; gcse.async = true;
gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
    '//www.google.com/cse/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(gcse, s);
})();

</script>