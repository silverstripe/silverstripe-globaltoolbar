<nav class="collapse navbar-collapse mobile-menu-holder" role="navigation">
    <ul class="nav nav-tabs nav-justified visible-xs">
        <li class="active">
            <a class="menu-title" href="#mobile-home" data-toggle="tab" title="Menu">MENU</a>
        </li>
        <li>
            <a class="ion-search" href="#search-box" data-toggle="tab" title="Search"></a>
        </li>
        <li>


            <iframe src="{$ToolbarHostname}/toolbar/profile" width="100%" height="40" frameborder="0" border="0"></iframe>        </li>
        <li>
            <a class="ion-ios7-close navbar-toggle collapsed visible-xs" href="#" title="Close" data-toggle="collapse" data-target=".navbar-collapse"></a>
        </li>
    </ul>
    <div class="tab-content visible-xs">
        
        <div id="mobile-home" class="tab-pane active mobile-nav">
            
            <ul class="nav">
                <li <% if ClassName == HomePage %>class="current"<% end_if %>><a href="./" title="Go to the Home page">Home</a></li>
                <% loop $Pages %>    
                    <li class="$LinkingMode">
                        <a href="$Link" title="Go to the $Title.XML page"><% if IsHelpdeskPage %><span class="locked"><% end_if %>$MenuTitle.XML<% if IsHelpdeskPage %></span><% end_if %></a>
                        <% if $LinkingMode == 'link' %><% else %>
                        <% if $Children %>
                        <ul class="nav">
                            <% loop $Children %>
                            <li class="$LinkingMode">
                                <a href="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a>
                                <% if $LinkingMode == 'link' %><% else %>
                                <% if $Children %>
                                <ul class="nav">
                                    <% loop $Children %>
                                    <li class="$LinkingMode">
                                        <a href="$Link" title="Go to the $Title.XML page">$MenuTitle.XML</a>
                                    </li>
                                    <% end_loop %>
                                </ul>
                                <% end_if %>
                                <% end_if %>
                            </li>
                            <% end_loop %>
                        </ul>
                        <% end_if %>
                        <% end_if %>
                    </li>
                <% end_loop %>
            </ul>
            
        </div>

        <div id="search-box" class="tab-pane border-top">
            <gcse:searchbox-only resultsUrl="{$BaseUrl}search/" enableAutoComplete="true"></gcse:searchbox-only>
        </div>

        <div id="mobile-login" class="tab-pane">
            <h3>Login</h3>
            $LoginForm
        </div>
    </div>
</nav>        
