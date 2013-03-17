# Global Toolbar

## Maintainer

 * Ingo Schommer (ingo at silverstripe dot com)

## Requirements

 * jQuery 1.4

## Description

Aggregates

## Usage

### Inclusion

See `test.html`. "Entries" refer to the internal array of allowed menu items
inside the `toolbar.js` file (`entries` array towards the bottom).

	<link rel="stylesheet" type="text/css" href="css/toolbar.css"></link>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="javascript/toolbar.js"></script>
	
Only certain parameters are configurable by URL for security reasons (e.g. you can't add menu entries).

### Filtering entries
	
	toolbar.js?filter=api,bugtracker
	
### Sorting entries

	toolbar.js?sort=bugtracker,api
	
## Current Menu Highlighting

	toolbar.js?site=api
	
It is based on the ID of the site which is one of the following

	* doc
	* api
	* open
	* forums
	* bugtracker
	* userhelp
	
### Custom form action

	toolbar.js?formAction=http://myhost.com/opensearch
	
## TODO

 * Allow selection of search sources