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
        <ul class="nav navbar-nav global-right pull-right">
            
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
                <iframe id="toolbar-iframe" src="{$ToolbarHostname}/toolbar/profile" width="50" height="50" frameborder="0" border="0"></iframe>
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

        <% include GlobalNavbar_Mobile ToolbarHostname=$ToolbarHostname, Pages=$Pages %>
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
        var desktopSearchElem = document.getElementById('desktopSearch');
        var navSearchA = document.querySelector('.nav-search a');
        var searchClose = document.querySelector('a.search-close');

        function desktopClose(elem) {
            $(searchClose).on('click', function (e) {
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
                if($(desktopSearchElem).hasClass('show')) {
                    var searchBox = $(desktopSearchElem).find('input.gsc-input');
                    setTimeout(function() {
                        $(searchBox).focus().select();
                    }, 10);
                    desktopClose(desktopSearchElem);
                }
            });
        }
        else console.log('no navsearch a');

    });

})();

// TODO: Is this really the best way to set the placeholder text?
(function() {
    var interval = window.setInterval(function() {
        if($('#gsc-i-id1').length) {                
            window.clearInterval(interval);                
            $('#gsc-i-id1').attr('placeholder', 'Search SilverStripe...');
        }
        if($('#gsc-i-id2').length) {                
            window.clearInterval(interval);                
            $('#gsc-i-id2').attr('placeholder', 'Search SilverStripe...');
        }
        if($('#gsc-i-id3').length) {                
            window.clearInterval(interval);                
            $('#gsc-i-id3').attr('placeholder', 'Search SilverStripe...');
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