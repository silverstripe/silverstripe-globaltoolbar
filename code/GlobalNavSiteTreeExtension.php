<?php

class GlobalNavSiteTreeExtension extends DataExtension {

	private static $db = array(
		'ShowInGlobalNav' => 'Boolean',
		'ShowChildrenInGlobalNav' => 'Boolean',
	);


	/**
	 * Gets the hostname
	 *
	 * @return string Protocol and hostname only
	 */
	public static function get_toolbar_hostname() {
		return Config::inst()->get('GlobalNav','use_localhost')
			? Director::protocolAndHost()
			: Config::inst()->get('GlobalNav','hostname');
	}

	/**
	 * Gets the base path for the global nav
	 *
	 * @return string Path including baseurl
	 */
	public static function get_toolbar_baseurl() {
		return Config::inst()->get('GlobalNav','use_localhost')
			? Director::absoluteBaseURL()
			: Config::inst()->get('GlobalNav','hostname');
	}

	public static function create_nav() {
		// remove the protocol from the URL, otherwise we run into https/http issues
		$url = self::remove_protocol_from_url(self::get_toolbar_hostname());
		$html = ViewableData::create()->customise(array(
				'ToolbarHostname' => $url,
				'Pages' => SiteTree::get()->filter(array(
				'ParentID' => 0,
				'ShowInGlobalNav' => true
			)),
			'GoogleCustomSearchId' => Config::inst()->get('GlobalNav', 'google_search_id')
		))->renderWith('GlobalNavbar');

		$path = Config::inst()->get('GlobalNav', 'snippet_path');

		file_put_contents(BASE_PATH . $path, $html);
	}    


	public function updateSettingsFields(FieldList $fields) {
		$p = $this->owner->Parent();
		if (!$p->exists()) {
			$fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowInGlobalNav','Show in global nav'));
			$fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowChildrenInGlobalNav','Include child pages')
				->displayIf('ShowInGlobalNav')->isChecked()
				->end()
			);
		} else if ($p->ShouldShowChildren()) {
			$fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowInGlobalNav','Show in global nav'));
		}
	}


	public function ShouldShowChildren() {
		return $this->owner->ShowInGlobalNav && $this->owner->ShowChildrenInGlobalNav;
	}


	public function GlobalNavLink() {
		if($this->IsExternal()) {
			return $this->owner->ExternalURL;		
		}
		return $this->owner->AbsoluteLink();
	}


	public function IsExternal() {
		return ($this->owner instanceof RedirectorPage && $this->owner->ExternalURL);
	}


	public function GlobalNavChildren() {
		return $this->owner->Children()->filter(array(
			'ShowInGlobalNav' => true,
		));
	}


	public function onAfterWrite() {
		if ($this->owner->ParentID == 0) {
			self::create_nav();
		}
	}

	/**
	 * This isn't the most amazingly appropriate place,
	 * but I can't think of a better one.
	 *
	 * @param string URL to remove the protocol from
	 * @return string URL with protocol removed
	 */
	protected static function remove_protocol_from_url($url) {
		$url = parse_url($url);
		unset($url['scheme']); // remove the scheme
		return self::unparse_url($url);
	}


	protected static function unparse_url($parsed_url) {
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
