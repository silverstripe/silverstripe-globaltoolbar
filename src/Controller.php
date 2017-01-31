<?php

namespace SilverStripe\Toolbar;

use SilverStripe\Control\Controller as BaseController;
use SilverStripe\View\Requirements;
use SilverStripe\View\SSViewer;
use SilverStripe\View\ThemeResourceLoader;

class Controller extends BaseController
{
    private static $allowed_actions = [
        'profile',
    ];

    protected function init()
    {
        parent::init();
        Requirements::css(SS_TOOLBAR_DIR . '/css/toolbar.css');
    }

    public function profile($request)
    {
        return $this->renderWith('GlobalToolbarProfile');
    }

    /**
     * Find a file by theme
     *
     * @param  string $filename A file path relative to the root folder of a theme
     * @return string|null
     */
    public function getThemedFile($filename)
    {
        return ThemeResourceLoader::instance()->findThemedResource($filename, SSViewer::get_themes());
    }
}
