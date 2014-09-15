<?php

/**
 * Class GlobalNavTemplateProvider
 *
 * Provides a global template variable "GlobalNav" that fill fetch a piece of HTML with curl from the location
 * defined in a config value. See toolbar/_config/config.yml (GlobalNav: snippet_path)
 *
 * Timeouts can be changed by setting config values
 *
 * GlobalNavTemplateProvider:
 *     connection_timeout: 100
 *     transfer_timeout: 200
 *
 */
class GlobalNavTemplateProvider implements TemplateGlobalProvider {

	/**
	 * @var int - timeout in ms
	 */
	private static $connection_timeout = 100;

	/**
	 * @var int - timeout in ms
	 */
	private static $transfer_timeout = 200;

	/**
	 * @var string|null
	 */
	protected static $global_nav_html = null;

	/**
	 * Called by SSViewer to get a list of global variables to expose to the template, the static method to call on
	 * this class to get the value for those variables, and the class to use for casting the returned value for use
	 * in a template
	 *
	 * @return array
	 */
	public static function get_template_global_variables() {
		return array(
			'GlobalNav',
		);
	}

	/**
	 * @return HTMLText
	 */
	public static function GlobalNav() {
		Requirements::css(Controller::join_links(GlobalNavSiteTreeExtension::get_toolbar_hostname(), Config::inst()->get('GlobalNav','css_path')));

		// If this method haven't been called before, get the toolbar and cache it
		if(self::$global_nav_html === null) {
			// Set the default to empty
			self::$global_nav_html = '';
			// Prevent recursion from happening
			if (empty($_GET['globaltoolbar'])) {
				$host = GlobalNavSiteTreeExtension::get_toolbar_hostname();
				$path = Config::inst()->get('GlobalNav','snippet_path');
				$url = Controller::join_links($host, $path, '?globaltoolbar=true');
				$connectionTimeout = Config::inst()->get('GlobalNavTemplateProvider', 'connection_timeout');
				$transferTimeout = Config::inst()->get('GlobalNavTemplateProvider', 'transfer_timeout');
				// Get the HTML and cache it
				self::$global_nav_html = self::curl_call($url, $connectionTimeout, $transferTimeout);
			}
		}

		$html = DBField::create_field('HTMLText', self::$global_nav_html);
		$html->setOptions(array('shortcodes' => false));
		return $html;
	}

	/**
	 * Get the result from the $url and logs any response that
	 * does not not have a response code between 200 - 299 or
	 * times out.
	 *
	 * @param string $url - full URL
	 * @param int $connectTimeoutMs - milliSeconds for connection timeout
	 * @param int $timeoutMs - milliseconds for transfer timeout
	 * @return string - the response body
	 */
	protected static function curl_call($url, $connectTimeoutMs = 100, $timeoutMs = 200) {
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_HEADER, true);

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_TIMEOUT_MS, $timeoutMs);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT_MS, $connectTimeoutMs);

		$response = curl_exec($ch);
		$responseParts = explode("\r\n\r\n", $response, 2);
		$responseInfo = curl_getinfo($ch);

		if(!empty($responseParts[1])) {
			list($header, $responseBody) = $responseParts;
		} else {
			$responseBody = $response;
		}

		if($response === false || curl_errno($ch)) {
			$message = 'Could not fetch toolbar from '.$url.': ' . curl_error($ch);
			SS_Log::log(new Exception($message, 500), SS_Log::ERR);
			return '';
		}

		if($responseInfo['http_code'] < 200 || $responseInfo['http_code'] > 299) {
			$message = 'Could not fetch toolbar, http_status "'.$responseInfo['http_code'].'" from "'.$url.'" ';
			SS_Log::log(new Exception($message, $responseInfo['http_code']), SS_Log::ERR);
			return '';
		}
		return $responseBody;
	}
}
