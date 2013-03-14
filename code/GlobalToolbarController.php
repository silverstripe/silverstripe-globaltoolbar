<?php
class GlobalToolbarController extends Controller {

	public function init() {
		parent::init();

		Requirements::css('toolbar/css/toolbar.css');
	}

	public function profile($request) {
		return $this->renderWith('GlobalToolbarProfile');
	}

}