# Global Toolbar

## Maintainer

 * Ingo Schommer (ingo at silverstripe dot com)

## Description

Injects a toolbar list of available SilverStripe community sites and additional controls. 
Operates through JavaScript, so can be inserted on any HTML page, regardless
if it runs on SilverStripe or not. The toolbar code itself is a SilverStripe module though,
and has some "active" components which determine the login status on the domain
the toolbar code is hosted (which might be different from the domain it is viewed on).

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