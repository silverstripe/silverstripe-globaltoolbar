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