<?php

namespace SilverStripe\Toolbar;

use SilverStripe\Control\Director;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Security\Permission;

class ControllerExtension extends DataExtension
{
    public function onBeforeInit()
    {
        $host = SiteTreeExtension::get_toolbar_hostname();
        if ((isset($_REQUEST['regenerate_nav']) || isset($_REQUEST['flush']))
            && $host == Director::protocolAndHost()
            && (Permission::check('ADMIN') || Director::isDev())
        ) {
            SiteTreeExtension::create_static_navs();
        }
    }
}
