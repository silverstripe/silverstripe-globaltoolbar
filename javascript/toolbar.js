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
			searchPlaceholder: "Search all SilverStripe.org sites",
			filterEntries: null,
			sortEntries: null,
			googleCseId: '006620299726686837192:uigdvjfexik',
			googleCseResultsUrl: 'http://www.silverstripe.org/search/',
			profileIframeUrl: 'http://www.silverstripe.org/toolbar/profile'
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
					'<div id="ss-globaltoolbar">' +
					'	<div class="inner">' +
					'		<div class="logo"></div>' +
					'		<div id="dd" class="wrapper-dropdown" tabindex="1"><span class="dropdown-placeholder">' + self.options.titleText + '</span><ul class="dropdown"></ul></div>' +
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

				// add to body
				html.prependTo($(self.options.prependTo));

				// Add Google CSE if requested and available
				if(self.options.searchShow) {
					inner.append('<div id="ss-globaltoolbar-cse-search" class="ss-globaltoolbar-cse-search" />');
					window.__gcse = {
						parsetags: 'explicit',
						callback: function() {
							var renderSearchElement = function() {
								google.search.cse.element.render({
									div: 'ss-globaltoolbar-cse-search',
									tag: 'searchbox-only',
									resultsUrl: self.options.googleCseResultsUrl
								});
								$('.ss-globaltoolbar-cse-search input[name=search]').attr('placeholder', self.options.searchPlaceholder);
							};
							if (document.readyState == 'complete') {
								renderSearchElement();
							} else {
								google.setOnLoadCallback(renderSearchElement, true);
							}
						}
					};
					var cx = self.options.googleCseId;
					var gcse = document.createElement('script'); gcse.type = 'text/javascript'; 
					gcse.async = true;
					gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
						'//www.google.com/cse/cse.js?cx=' + cx;
			    var s = document.getElementsByTagName('script')[0]; 
			    s.parentNode.insertBefore(gcse, s);
				}

				// Add profile iframe
				profile = $('<div id="ss-globaltoolbar-profile" class="ss-globaltoolbar-profile" />');
				profileIframe = $('<iframe />').attr({
					src: self.options.profileIframeUrl,
					border: 0,
					frameBorder: 0,
					width: '100%',
					height: '40px'
				});
				profile.append(profileIframe);
				
				// TODO Fix profile styling
				// inner.append(profile);
				
				// add a class to the body so we can pad it down
				$("body").addClass('has-ss-globaltoolbar');
			}
		};
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
				'url': 'http://www.silverstripe.org',
				'title': 'Main Website'
			},
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
				'id': 'addons',
				'url': 'http://addons.silverstripe.org',
				'title': 'Addons'
			},
			{
				'id': 'bugtracker',
				'url': 'http://doc.silverstripe.org/framework/en/trunk/misc/contributing/issues',
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

		//Site Dropdown 

		function DropDown(el) {
			this.dd = el;
			this.initEvents();
		}
		DropDown.prototype = {
			initEvents : function() {
				var obj = this;

				obj.dd.on('click', function(event){
					$(this).toggleClass('active');
					event.stopPropagation();
				});
			}
		}

		$(function() {
			var dd = new DropDown( $('#dd') );
			$(document).click(function() {
				// all dropdowns
				$('.wrapper-dropdown').removeClass('active');
			});
		});
	});
}(jQuery));