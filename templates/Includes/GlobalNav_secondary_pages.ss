<% if $Pages %>
<nav class="navbar navbar-inverse navbar-secondary-dropdown">
    <div class="container-fluid">
        <% if $InNode(blog) %><% include Nav_BlogArchive %><% end_if %>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" role="navigation">
                <% loop $Pages %>
                <li class="<% if $ClassName == 'SilverStripe\\Blog\\Model\\BlogCategory' %>$LinkingMode<% else_if $Up.ActivePageID == $ID %>current active<% else_if $Up.ActiveParentID == $ID %>section active<% end_if %>">
                    <a href="$GlobalNavLink" title="<% if $ClassName == 'SilverStripe\\Blog\\Model\\BlogCategory' %> Filter by<% else %> Go to the<% end_if %> $Title.XML<% if $ClassName != 'SilverStripe\\Blog\\Model\\BlogCategory' %> page<% end_if %>"
                    class="<% if $HighlightMenu %>btn btn-default <% end_if %>">
                    $MenuTitle.XML
                    </a>
                </li>
                <% end_loop %>
            </ul>
        </div>
    </div>
</nav>
<% end_if %>
