<?php

class GlobalNavExtension extends DataExtension
{

    private static $db = array (
        'ShowInGlobalNav' => 'Boolean',
        'ShowChildrenInGlobalNav' => 'Boolean'
    );


    public function updateSettingsFields(FieldList $fields) {
        $p = $this->owner->Parent();
        if(!$p->exists()) {
            $fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowInGlobalNav','Show in global nav'));
            $fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowChildrenInGlobalNav','Include child pages')
                                                        ->displayIf('ShowInGlobalNav')->isChecked()
                                                        ->end()
            );
        }

        else if($p->ShouldShowChildren()) {
            $fields->addFieldToTab("Root.Settings", CheckboxField::create('ShowInGlobalNav','Show in global nav'));        
        }
    }


    public function ShouldShowChildren() {
        return $this->owner->ShowInGlobalNav && $this->owner->ShowChildrenInGlobalNav;
    }


    public function GlobalNavLink() {
        if($this->owner instanceof RedirectorPage && $this->owner->ExternalURL) {
            return $this->owner->ExternalURL;
        }

        return Controller::join_links(Director::absoluteBaseURL(), $this->owner->Link());
    }


    public function GlobalNavChildren() {
        return $this->owner->Children()
                    ->filter(array(
                        'ShowInGlobalNav' => true
                    ));
    }


    public function GlobalNav() {        
        $host = $this->getToolbarHostname();        
        if(isset($_REQUEST['flush']) && $host == Director::absoluteBaseURL()) {
            $this->createNav();        
        }

        $path = Config::inst()->get('GlobalNav','snippet_path');
        $html = file_get_contents(Controller::join_links($this->getToolbarHostname(),$path));

        Requirements::css(Controller::join_links($host, Config::inst()->get('GlobalNav','css_path')));
        return $html;
    }


    public function onAfterWrite() {
        if($this->owner->ParentID == 0) {
            $this->createNav();
        }
    }



    protected function getToolbarHostname() {
        return  Config::inst()->get('GlobalNav','use_localhost') ? 
                Director::absoluteBaseURL() :
                Config::inst()->get('GlobalNav','hostname');        
    }


    protected function createNav() {
        $html = ViewableData::create()->customise(array(
            'ToolbarHostname' => $this->getToolbarHostname(),
            'Pages' => SiteTree::get()->filter(array(
                'ParentID' => 0,
                'ShowInGlobalNav' => true
            )),
            'GoogleCustomSearchId' => Config::inst()->get('GlobalNav', 'google_search_id')
        ))->renderWith('GlobalNavbar');

        $path = Config::inst()->get('GlobalNav','snippet_path');
        file_put_contents(BASE_PATH.$path, $html);        
    }
}