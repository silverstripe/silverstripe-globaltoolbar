<?php

class GlobalNavControllerExtension extends DataExtension {

	public function onBeforeInit() {
		$host = GlobalNavSiteTreeExtension::get_toolbar_hostname();
		if (isset($_REQUEST['regenerate_nav']) && $host == Director::absoluteBaseURL() && Permission::check('ADMIN')) {
			GlobalNavSiteTreeExtension::create_nav();
		}
	}
}
