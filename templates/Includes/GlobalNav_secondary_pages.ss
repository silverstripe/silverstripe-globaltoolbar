<div class="navbar-collapse collapse">
    <% if $Pages %>
    <ul class="nav navbar-nav" role="navigation">
    	<% loop $Pages %>
    		<li class="<% if $Up.ActivePageID == $ID %>current active<% else_if $Up.ActiveParentID == $ID %>section active<% end_if %>">
    			<a href="$GlobalNavLink" title="<% if $ClassName = 'BlogCategory' %> Filter by<% else %> Go to the<% end_if %> $Title.XML<% if $ClassName != 'BlogCategory' %> page<% end_if %>" 
    			class="<% if $HighlightMenu %>btn btn-default <% end_if %>">
    				$MenuTitle.XML
    			</a>
    		</li>
    	<% end_loop %>
    </ul>
     <% end_if %>
</div> <!--/.navbar-collapse -->