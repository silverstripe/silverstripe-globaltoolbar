<?php

class GlobalNavIteratorProperties implements TemplateIteratorProvider {

	public static function get_template_iterator_variables() {
		return array(
			'GlobalNav',
		);
	}

	public function iteratorProperties($pos, $totalItems) {
		$host = GlobalNavSiteTreeExtension::get_toolbar_hostname();
		$path = Config::inst()->get('GlobalNav','snippet_path');
		$html = file_get_contents(Controller::join_links($host,$path));
		$this->globalNav = $html;
	}



	public function GlobalNav() {
		Requirements::css(Controller::join_links(GlobalNavSiteTreeExtension::get_toolbar_hostname(), Config::inst()->get('GlobalNav','css_path')));

		$html = DBField::create_field('HTMLText',$this->globalNav);
		$html->setOptions(array('shortcodes' => false));

		return $html;
	}

}
