<?php

class GlobalNavSiteTreeExtension extends DataExtension
{

    private static $db = array (
        'ShowInGlobalNav' => 'Boolean',
        'ShowChildrenInGlobalNav' => 'Boolean'
    );


    public static function get_toolbar_hostname() {
        return  Config::inst()->get('GlobalNav','use_localhost') ? 
                Director::absoluteBaseURL() :
                Config::inst()->get('GlobalNav','hostname');        
    }


    public static function create_nav() {        
        $html = ViewableData::create()->customise(array(
            'ToolbarHostname' => self::get_toolbar_hostname(),
            'Pages' => SiteTree::get()->filter(array(
                'ParentID' => 0,
                'ShowInGlobalNav' => true
            )),
            'GoogleCustomSearchId' => Config::inst()->get('GlobalNav', 'google_search_id')
        ))->renderWith('GlobalNavbar');

        $path = Config::inst()->get('GlobalNav','snippet_path');
        
        file_put_contents(BASE_PATH.$path, $html);        
    }    


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


    public function onAfterWrite() {
        if($this->owner->ParentID == 0) {
            self::create_nav();
        }
    }

}