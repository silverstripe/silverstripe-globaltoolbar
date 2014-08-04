<nav class="collapse navbar-collapse mobile-menu-holder" role="navigation">
    <ul class="nav nav-tabs nav-justified visible-xs">
        <li class="active">
            <a class="menu-title" href="#mobile-home" data-toggle="tab" title="Menu">MENU</a>
        </li>
        <li>
            <a class="ion-ios7-search-strong" href="#search-box" data-toggle="tab" title="Search"></a>
        </li>
        <li class="profile-tab">
            <% if CurrentMember %>
                <a href="#mobile-login" class="profile" title="$CurrentMember.Nickname profile">$CurrentMember.Avatar.CroppedImage(24,24)</a>
                <!-- <iframe src="{$ToolbarHostname}/toolbar/profile" width="40px" height="40" frameborder="0" border="0"></iframe> -->
            <% else %>
                <a class="ion-ios7-contact-outline" href="#mobile-login" data-toggle="tab" title="Profile"></a>
            <% end_if %>  
        </li>
        <li>
            <a class="navbar-toggle collapsed ion-navicon" href="#" title="Close" data-toggle="collapse" data-target=".navbar-collapse"></a>
        </li>
    </ul>

    <div class="tab-content visible-xs">
        <div id="mobile-home" class="tab-pane active mobile-nav">
            <ul class="nav">
                <li><a href="$ToolbarHostname" title="Go to the Home page">Home</a></li>
                <% loop $Pages %>    
                    <li class="">
                        <a href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML</a>                        
                        <% if $Children %>
                        <ul data-id="$ID" class="nav">
                            <% loop $Children %>
                            <li class="">
                                <a data-parent-id="$ParentID" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML</a>                                
                                <% if $Children %>
                                <ul data-id="$ID" class="nav">
                                    <% loop $Children %>
                                    <li class="">
                                        <a data-parent-id="$ParentID" href="$GlobalNavLink" title="Go to the $Title.XML page">$MenuTitle.XML</a>
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
        </div>

        <div id="search-box" class="tab-pane border-top">
            <p>Searchbox here</p> <%-- removed for moment as breaks search focus (include SearchBox.ss) --%>
        </div>

        <div id="mobile-login" class="tab-pane mobile-nav">
            <% if CurrentMember %>
                <ul class="nav">
                    <li class="profile-preview">
                        <a class="profile-name" title="$CurrentMember.Nickname profile" href="{$BaseHref}ForumMemberProfile/show/$CurrentMember.ID">
                            <span class="has-img-user" >$CurrentMember.Avatar.CroppedImage(60,60)</span>
                            <p><small>My profile</small></p>
                            <h3>$CurrentMember.FirstName $CurrentMember.Surname</h3>
                            <h5>$CurrentMember.Nickname</h5>
                        </a>
                    </li>
                    <li>
                        <a href="">Directory listings</a>
                    </li>
                    <li>
                        <a href="">My showcase</a>
                    </li>
                    <li>
                        <a href="{$BaseHref}Security/logout">Log out</a>
                    </li>
                </ul>
            <% else %>
                <h3>Login</h3>
                $LoginForm
            <% end_if %>
        </div>
    </div>
</nav>