<?php

class GlobalNavControllerExtension extends DataExtension {

	public function onBeforeInit() {
		$host = GlobalNavSiteTreeExtension::get_toolbar_hostname();
		//if (isset($_REQUEST['flush']) && $host == Director::absoluteBaseURL()) {
			GlobalNavSiteTreeExtension::create_nav();
		//}
	}
}
