<div id="ss-globaltoolbar">
<nav class="navbar navbar-inverse navbar-global" role="navigation">
    <div class="container">
        <h1 class="visible-xs">$Title</h1>

        <%-- Brand and toggle get grouped for better mobile display --%>
        <div class="navbar-header">
            <a class="navbar-brand" href="$BaseHref">
                <span>SilverStripe</span>
            </a>

            <a class="navbar-toggle collapsed visible-xs" href="#" title="Close" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="ion-navicon"></span>
            </a>
        </div>

        <%-- Profile menu --%>
        <ul class="nav navbar-nav global-right hidden-xs">

            <iframe src="{$ToolbarHostname}/toolbar/profile" width="100%" height="40" frameborder="0" border="0"></iframe>
        </ul>

        <%-- Navigation top level --%>
        
            <ul class="nav navbar-nav global-nav hidden-xs" role="navigation">
                <% loop $Pages %>    
                    <li>
                        <a href="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a>
                    </li>
                <% end_loop %>
            </ul>
        

    </div>
</nav>
</div>
<script type="text/javascript">
(function() {
var a;if(a = document.querySelector('.nav a[href="'+window.location.pathname+'"]')) a.parentNode.classList.add('current');
})();
</script>
