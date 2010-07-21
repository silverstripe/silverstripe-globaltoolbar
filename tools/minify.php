<?php
/**
 * Call via "make minify" on /toolbar folder
 * 
 * @author Ingo Schommer
 */

require_once realpath('../sapphire/thirdparty/jsmin/JSMin.php');
$in = realpath('javascript') . '/toolbar.js';
$out = realpath('javascript') . '/toolbar.min.js';

$js = file_get_contents($in);
file_put_contents($out, JSMin::minify($js));
echo sprintf('Written "%s"' . "\n", $out);