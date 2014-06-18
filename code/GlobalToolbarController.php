<?php
class GlobalToolbarController extends Controller {

    private static $allowed_actions = array (
        'profile'
    );

	public function init() {
		parent::init();

		Requirements::css('toolbar/css/toolbar.css');
	}

	public function profile($request) {        
		return $this->renderWith('GlobalToolbarProfile');
	}

}