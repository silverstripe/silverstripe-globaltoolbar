<?php

class GlobalNavExtension extends DataExtension
{

    private static $db = array (
        'ShowInGlobalNav' => 'Boolean'
    );



    public function updateSettingsFields(FieldList $fields) {
        if($this->owner->ParentID == 0) {
            $fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowInGlobalNav','Show in global nav'));
        }
    }


    public function GlobalNav() {        
        if(isset($_REQUEST['flush'])) {
            $this->createNav();
        }

        $path = Config::inst()->get('GlobalNav','snippet_path');

        $html = @file_get_contents($this->getToolbarHostname().$path);

        return $html;
    }


    public function onAfterWrite() {
        if($this->owner->ParentID == 0) {
            $this->createNav();
        }
    }



    protected function getToolbarHostname() {
        return  Config::inst()->get('GlobalNav','use_localhost') ? 
                Director::protocolAndHost() : 
                Config::inst()->get('GlobalNav','hostname');        
    }


    protected function createNav() {
        $html = ViewableData::create()->customise(array(
            'ToolbarHostname' => $this->getToolbarHostname(),
            'Pages' => SiteTree::get()->filter(array(
                'ParentID' => 0,
                'ShowInGlobalNav' => true
            ))
        ))->renderWith('GlobalNavbar');

        $path = Config::inst()->get('GlobalNav','snippet_path');
        file_put_contents(BASE_PATH.$path, $html);        
    }
}