# Global Toolbar

## Maintainer

 * Aaron Carlino (aaron at silverstripe dot com)

## Description

Injects a toolbar list of available SilverStripe community sites and additional controls. 
Creates static HTML files of the menu for each of the configured subdomains, with the correct state 
applied to the navigation, e.g. `global-nav-doc.html`, `global-nav-addons.html`.

## Configuration

Using arbitrary unique keys to identify each subdomain, map it to the ID a page in the hierarchy of the main site.

```yml
---
Name: my-toolbar
After:
  - toolbar/*  
---
GlobalNav:
  static_navs:
    doc: 1560
    userhelp: 1556
    api: 1559
    addons: 16
```
## Usage on the "host" site

The main site is referred to as the "host" because it serves the static HTML menus from its `assets/` directory. All other sites consume it with a simple HTTP request, e.g. `file_get_contents`.

In the CMS, on the `Settings` tab of each page, you can activate **Show in Global nav** to include it. By default, not all pages in the top level navigation are included in the global nav.

You can also activate **Show children in global nav**, which will provide each of the page's children with a **Show in global nav** option.

When a page is saved, and it is included in the global nav, the new static HTML files are created.

On the main site, the menu is rendered dynamically, and does not read off the static files. Partial caching should be implemented to give static-like performance.

## Usage on a consumer site

Simply invoke `$GlobalNav('key')` in a SilverStripe template, where 'key' is the unique identifier of the consumer, e.g. `$GlobalNav('doc')`.

If the site is not running SilverStripe, it should be trivial to implement a simple HTTP request using cURL or `file_get_contents` to retrieve the `global-nav.html` file or the consumer site.


## Forcing regeneration of the nav

Append `?regenerate_nav=1` to the GET request.