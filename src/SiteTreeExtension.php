<?php

namespace SilverStripe\Toolbar;

use SilverStripe\Control\Director;
use SilverStripe\Core\Config\Config;
use SilverStripe\CMS\Controllers\ModelAsController;
use SilverStripe\CMS\Model\RedirectorPage;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\ORM\DataExtension;
use SilverStripe\ORM\Versioning\Versioned;
use SilverStripe\View\ViewableData;

class SiteTreeExtension extends DataExtension
{
    /**
     * Gets the hostname
     *
     * @return string Protocol and hostname only
     */
    public static function get_toolbar_hostname()
    {
        return Config::inst()->get('GlobalNav', 'use_localhost')
            ? Director::protocolAndHost()
            : Config::inst()->get('GlobalNav', 'hostname');
    }

    /**
     * Gets the base path for the global nav
     *
     * @return string Path including baseurl
     */
    public static function get_toolbar_baseurl()
    {
        return Config::inst()->get('GlobalNav', 'use_localhost')
            ? Director::absoluteBaseURL()
            : Config::inst()->get('GlobalNav', 'hostname');
    }

    public static function is_host()
    {
        return self::get_toolbar_baseurl() == Director::absoluteBaseURL();
    }

    public static function get_navbar_html($page = null)
    {
        // remove the protocol from the URL, otherwise we run into https/http issues
        $url = self::remove_protocol_from_url(self::get_toolbar_hostname());
        $static = true;
        if (!$page instanceof SiteTree) {
            $page = Director::get_current_page();
            $static = false;
        }

        // In some cases, controllers are bound to "mock" pages, like Security. In that case,
        // throw the "default section" as the current controller.
        if (!$page instanceof SiteTree || !$page->isInDB()) {
            $controller = ModelAsController::controller_for(
                $page = SiteTree::get_by_link(
                    Config::inst()->get('GlobalNav', 'default_section')
                )
            );
        } else {
            // Use controller_for to negotiate sub controllers, e.g. /showcase/listing/slug
            // (Controller::curr() would return the nested RequestHandler)
            $controller = ModelAsController::controller_for($page);
        }


        // Ensure staging links are not exported to the nav
        $origStage = Versioned::get_reading_mode();
        Versioned::set_reading_mode('Stage.Live');

        $html = ViewableData::create()->customise(array(
            'ToolbarHostname' => $url,
            'Scope' => $controller,
            'ActivePage' => $page,
            'ActiveParent' => ($page instanceof SiteTree && $page->Parent()->exists()) ? $page->Parent() : $page,
            'StaticRender' => $static,
            'GoogleCustomSearchId' => Config::inst()->get('GlobalNav', 'google_search_id')
        ))->renderWith('GlobalNavbar');

        Versioned::set_reading_mode($origStage);

        return $html;
    }

    public static function get_navbar_filename($key)
    {
        return Controller::join_links(
            BASE_PATH,
            Config::inst()->get('GlobalNav', 'snippet_path'),
            'global-nav-'.$key.'.html'
        );
    }

    public static function create_static_navs()
    {
        $domains = Config::inst()->get('GlobalNav', 'static_navs');
        if ($domains) {
            foreach ($domains as $key => $id) {
                $page = SiteTree::get()->byID($id);
                if (!$page) {
                    continue;
                }

                $filename = self::get_navbar_filename($key);
                file_put_contents($filename, self::get_navbar_html($page));
            }
        }
    }

    public function GlobalNavLink()
    {
        $link = $this->IsExternal() ? $this->owner->ExternalURL : $this->owner->Link();
        $this->owner->invokeWithExtensions('updateGlobalNavLink', $link);

        return $link;
    }

    public function IsExternal()
    {
        return ($this->owner instanceof RedirectorPage && $this->owner->ExternalURL);
    }

    public function InNode($parentID)
    {
        $page = $this->owner;
        $field = is_numeric($parentID) ? 'ID' : 'URLSegment';
        while ($page) {
            if ($parentID == $page->$field) {
                return true;
            }
            $page = $page->Parent;
        }
        return false;
    }

    protected function needsRegeneration()
    {
        $fields = Config::inst()->get('GlobalNav', 'regenerate_on_changed');
        if ($fields) {
            $changed = $this->owner->getChangedFields(true);
            // ->isChanged($field) was returning false positives. No idea why.
            foreach ($fields as $field) {
                if (isset($changed[$field])) {
                    if ($changed[$field]['before'] != $changed[$field]['after']) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    // Can be overriden by pages
    public function GlobalNavChildren()
    {
        return $this->owner->Children();
    }

    public function onAfterWrite()
    {
        if ($this->owner->ParentID == 0 && $this->needsRegeneration()) {
            self::create_static_navs();
        }
    }

    /**
     * This isn't the most amazingly appropriate place,
     * but I can't think of a better one.
     *
     * @param string URL to remove the protocol from
     * @return string URL with protocol removed
     */
    protected static function remove_protocol_from_url($url)
    {
        $url = parse_url($url);
        unset($url['scheme']); // remove the scheme
        return self::unparse_url($url);
    }

    protected static function unparse_url($parsed_url)
    {
        $scheme = isset($parsed_url['scheme']) ? $parsed_url['scheme'] . '://' : '//';
        $host = isset($parsed_url['host']) ? $parsed_url['host'] : '';
        $port = isset($parsed_url['port']) ? ':' . $parsed_url['port'] : '';
        $user = isset($parsed_url['user']) ? $parsed_url['user'] : '';
        $pass = isset($parsed_url['pass']) ? ':' . $parsed_url['pass']  : '';
        $pass = ($user || $pass) ? "$pass@" : '';
        $path = isset($parsed_url['path']) ? $parsed_url['path'] : '';
        $query = isset($parsed_url['query']) ? '?' . $parsed_url['query'] : '';
        $fragment = isset($parsed_url['fragment']) ? '#' . $parsed_url['fragment'] : '';
        return "$scheme$user$pass$host$port$path$query$fragment";
    }
}
