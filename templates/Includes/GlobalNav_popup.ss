<nav class="hidden-xs">
	<div class="popup-primary-nav">

		<a class="navbar-menu-close js-nav-trigger hidden-xs" href="#">
			<span class="sr-only">Site Menu</span>
			<span class="icon ion-close"></span>
		</a>

		<h3>
			<span class="sr-only">SilverStripe</span>
			<img src="{$ToolbarHostname}/themes/ssv3/img/brand/logo-lg-nav.png" alt="SilverStripe" />
		</h3>
		<div class="popup-holder" role="navigation">
		<% loop $Scope.Menu(1) %>
			<div class="popup-primary-section $LinkingMode">
				<img src="{$Top.ToolbarHostname}/themes/ssv3/img/icons/section-{$URLSegment}.png" alt="$Title" />
				<h5><a href="$GlobalNavLink">$MenuTitle.XML</a></h5>
				<% if Children %>
				<ul>
					<% loop Children %>
					<li class="$LinkingMode"><a href="$GlobalNavLink">$MenuTitle.XML</a></li>
					<% end_loop %>
				</ul>
				<% end_if %>
			</div>
		<% end_loop %>
		</div>
	</div>
</nav>