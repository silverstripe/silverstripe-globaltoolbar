<?php

namespace SilverStripe\Toolbar;

use SilverStripe\Control\Controller as BaseController;
use SilverStripe\View\Requirements;

class Controller extends BaseController 
{

	private static $allowed_actions = [
		'profile',
	];

	public function init() 
	{
		parent::init();
		Requirements::css('toolbar/css/toolbar.css');
	}

	public function profile($request) 
	{
		return $this->renderWith('GlobalToolbarProfile');
	}
}
