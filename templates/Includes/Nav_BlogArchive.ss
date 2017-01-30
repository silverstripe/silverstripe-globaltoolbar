<ul class="nav navbar-nav secondary-right hidden-xs">
	<li class="link">
		<a class="icon ion-social-rss" href="<% if $ClassName == 'BlogHolder' %>{$Link}rss<% else %>{$Parent.Link}rss<% end_if %>" title="RSS Feed"><span class="sr-only">RSS Feed</span></a>
	</li>
	<li class="link">
		<a class="icon ion-android-folder" href="<% if $ClassName == 'BlogHolder' %>{$Link}archive<% else %>{$Parent.Link}archive<% end_if %>" title="Archive"><span class="sr-only">Archive</span></a>
	</li>
</ul>
