<?php

class GlobalNavExtension extends DataExtension
{

    private static $db = array (
        'ShowInGlobalNav' => 'Boolean'
    );


    public function updateCMSFields(FieldList $fields) {
        $fields->addFieldToTab("Root.Main", CheckboxField::create('ShowInGlobalNav','Show in global nav'),'Content');
    }


    public function GlobalNav() {        
        if(isset($_REQUEST['flush'])) {
            $this->createNav();
        }

        $path = Config::inst()->get('GlobalNav','snippet_path');
        $hostname = Config::inst()->get('GlobalNav','hostname');
        $url = $hostname.$path;

        $html = file_get_contents($url);

        return $html;
    }


    public function onAfterWrite() {
        if($this->owner->ParentID == 0) {
            $this->createNav();
        }
    }


    protected function createNav() {
        $html = ViewableData::create()->customise(array(
            'Pages' => SiteTree::get()->filter(array(
                'ParentID' => 0,
                'ShowInGlobalNav' => true
            ))
        ))->renderWith('GlobalNavbar');

        $path = Config::inst()->get('GlobalNav','snippet_path');
        file_put_contents(BASE_PATH.$path, $html);        
    }
}