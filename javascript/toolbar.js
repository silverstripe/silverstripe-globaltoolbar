var ss = ss || {};
(function($) {
	/**
	 * Renders a global navigation bar
	 * 
	 * Author: Ingo Schommer (ingo at silverstripe dot com)
	 */
	ss.GlobalToolbar = function() {
		
		// private
		var entries, options, self = this;
		var defaults = {
			prependTo: 'body',
			titleText: 'SilverStripe.org sites',
			searchShow: true,
			searchLabelText: 'Search on SilverStripe.org sites',
			searchButtonText: '',
			formAction: 'http://silverstripe.org/globalsearch',
			filterEntries: null,
			sortEntries: null
		};
		
		// public
		return {
			/**
			 * Function: init
			 * 
			 * Parameters:
			 *  (Array) entries
			 *  (Object) options
			 */
			init: function(entries, options) {
				self.options = $.extend({}, defaults, options);
				self.entries = (options.filterEntries) ? this.filterEntries(entries, options.filterEntries) : entries;
				if(options.sortEntries) self.entries = this.sortEntries(self.entries);
			},
			
			/**
			 * Function: filterEntries
			 * 
			 * Parameters:
			 *  (Array) entries
			 *  (Array) filterList
			 * 
			 * Returns:
			 *  (Array)
			 */
			filterEntries: function(entries, filterList) {
				return $.grep(entries, function(el) {
					return ($.inArray(el.id, filterList) != -1) ? el : null;
				});
			},
			
			/**
			 * Function: sortEntries
			 * 
			 * Todo:
			 *  Fix sorting
			 */
			sortEntries: function(entries, sortList) {
				// entries.sort(function(a, b) {
				// });
				return entries;
			},
			
			/**
			 * Function: render
			 * 
			 * Renders the markup into the current document
			 */
			render: function() {
				var html = $(
					'<div class="ss-globaltoolbar">' +
					'	<div class="ss-globaltoolbar-shadow">' +
					'		<div class="inner">' +
					'			<div class="logo"><span>' + self.options.titleText + '</span></div>' +
					'			<ul></ul>'  +
					'		</div>' +
					'	</div>' +
					'</div>'
				);
				
				var ul = $('ul', html), inner = $('.inner', html);
				var linkingMode = "link";
				
				for(var i=0; i<self.entries.length; i++) {
					var entry = self.entries[i];
					
					linkingMode = (self.options.currentSite && (entry.id === self.options.currentSite)) ? "current" : "link";
					
					ul.append(
						'<li class="'+ linkingMode +'">' +
						' <a href="' + entry.url + '"><span>' + entry.title + '</span></a>' +
						'</li>'
					);
				}
				
				if(self.options.searchShow) {
					inner.append(
						' <form class="Search" action="' + self.options.formAction + '">' +
						'  <fieldset>' +
						'   <input type="text" name="q" class="text" value="' + self.options.searchLabelText + '"/>' +
						'   <button type="submit" class="submit">' + self.options.searchButtonText + '</button>' +
						'  </fieldset>' +
						' </form>'
					);
				}
				
				// add to body
				html.prependTo($(self.options.prependTo));
				
				// add a class to the body so we can pad it down
				$("body").addClass('has-ss-globaltoolbar');
				
				// Toggle default label for input field
				$('input.text', html).focus(function(e) {
						if($(this).val() == self.options.searchLabelText) $(this).val('').data('emptied', true);
				}, function(e) {
					if($(this).val() == '') $(this).val(self.options.searchLabelText);
				});
			}
		}
	}();
	
	/* Client-side access to querystring name=value pairs
		Version 1.3
		28 May 2008

		License (Simplified BSD):
		http://adamv.com/dev/javascript/qslicense.txt
	*/
	function Querystring(qs) { // optionally pass a querystring to parse
		this.params = {};

		if (qs == null) qs = location.search.substring(1, location.search.length);
		if (qs.length == 0) return;

	// Turn <plus> back to <space>
	// See: http://www.w3.org/TR/REC-html40/interact/forms.html#h-17.13.4.1
		qs = qs.replace(/\+/g, ' ');
		var args = qs.split('&'); // parse out name/value pairs separated via &

	// split out each name=value pair
		for (var i = 0; i < args.length; i++) {
			var pair = args[i].split('=');
			var name = decodeURIComponent(pair[0]);

			var value = (pair.length==2)
				? decodeURIComponent(pair[1])
				: name;

			this.params[name] = value;
		}
	}

	Querystring.prototype.get = function(key, default_) {
		var value = this.params[key];
		return (value != null) ? value : default_;
	}

	Querystring.prototype.contains = function(key) {
		var value = this.params[key];
		return (value != null);
	}
	
	// init
	$(document).ready(function() {
		var entries = [
			{
				'id': 'doc',
				'url': 'http://doc.silverstripe.org',
				'title': 'Documentation'
			},
			{
				'id': 'api',
				'url': 'http://api.silverstripe.org',
				'title': 'API'
			},
			{
				'id': 'forums',
				'url': 'http://silverstripe.org/forums',
				'title': 'Forum'
			},
			{
				'id': 'userhelp',
				'url': 'http://userhelp.silverstripe.org',
				'title': 'User help'
			},
			{
				'id': 'bugtracker',
				'url': 'http://open.silverstripe.org',
				'title': 'Bugtracker'
			}
		];

		// parse query params
		var js = /toolbar(\.min)?\.js(\?.*)?$/, options = {};
		jQuery('script[src]').each(function(i, el) {
			var urlMatches = el.src.match(js); // gets query string
			if(urlMatches && urlMatches[2]) {
				var query = urlMatches[2].replace(/.*\?/, '');
				var qs = new Querystring(query);
				if(qs.get('filter')) options.filterEntries = qs.get('filter').split(',');
				if(qs.get('sort')) options.sortEntries = qs.get('sort').split(',');
				if(qs.get('formAction')) options.formAction = qs.get('formAction');
				if(qs.get('site')) options.currentSite = qs.get('site');
				if(qs.get('searchShow')) options.searchShow = (qs.get('searchShow') != "false" && qs.get('searchShow') != 0);
			}
		});

		// initalize toolbar
		ss.GlobalToolbar.init(entries, options);
		ss.GlobalToolbar.render();
		
		// Add opensearch (TODO Implement globalsearch and doc search)
		// $('head').append('<link type="application/opensearchdescription+xml" rel="search" href="globalsearch/opensearchdescription" title="silverstripe.org (Global Search)" /> ');
		$('head').append('<link type="application/opensearchdescription+xml" rel="search" href="http://open.silverstripe.org/search/opensearch" title="open.silverstripe.org (Bugtracker)" />');
		// $('head').append('<link type="application/opensearchdescription+xml" rel="search" href="http://doc.silverstripe.org/lib/exe/opensearch.php" title="doc.silverstripe.org (Wiki)" /> ');		
	});
}(jQuery));