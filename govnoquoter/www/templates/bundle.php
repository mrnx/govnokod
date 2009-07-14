<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2005-2009
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

/**
 * Код для сборки js и css файлов в один большой и расположение его на ФС для последующей отдачи средствами веб-сервера
 *
 * @package system
 * @subpackage template
 * @version 0.1.2
 */

require_once '../configs/config.php';
require_once systemConfig::$pathToSystem . '/core/fileLoader.php';

require_once systemConfig::$pathToSystem . '/resolver/iResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/fileResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/compositeResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/sysFileResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/appFileResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/moduleMediaResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/extensionBasedModuleMediaResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/templateMediaResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/decoratingResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/cachingResolver.php';
require_once systemConfig::$pathToSystem . '/resolver/classFileResolver.php';

$baseresolver = new compositeResolver();
$baseresolver->addResolver(new appFileResolver());
$baseresolver->addResolver(new sysFileResolver());

$resolver = new compositeResolver();
$resolver->addResolver(new templateMediaResolver($baseresolver));
$resolver->addResolver(new moduleMediaResolver($baseresolver));
$resolver->addResolver(new extensionBasedModuleMediaResolver($baseresolver));
$resolver->addResolver(new classFileResolver($baseresolver));

$resolver = new cachingResolver($resolver, 'resolver.media.cache');
fileLoader::setResolver($resolver);
fileLoader::load('exceptions/init');

fileLoader::load('request/httpRequest');
$request = new httpRequest();

$pathToTemplates = dirname(__FILE__);
$hash = $request->getString('hash', SC_GET);
$filesString = $request->getString('files', SC_GET);

$mimes = array('js' => 'application/x-javascript', 'css' => 'text/css');
$ext = substr(strrchr($filesString, '.'), 1);

$strippedHash = str_ireplace('.' . $ext, '', $hash);

if ($filesString !== null && $hash !== null && isset($mimes[$ext]) && $strippedHash === md5($filesString)) {
    $files = explode(',', $filesString);
    if ($files) {
        $source = generateSource($files, $resolver);

        file_put_contents(systemConfig::$pathToApplication . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . 'media' . DIRECTORY_SEPARATOR . $hash, $source);
        header('Location: ' . SITE_PATH . '/templates/media/' . $hash . '?files=' . $filesString);
        exit;
    }
}

function generateSource(Array $files, iResolver $resolver)
{
    $fileNameReplacePatterns = array('..' => '');
    $source = null;
    $filemtime = null;

    foreach ($files as $file) {
        $file = preg_replace('![^a-z\d_\-/.]!i', '', $file);

        $file = str_replace(array_keys($fileNameReplacePatterns), $fileNameReplacePatterns, $file);
        $filePath = $resolver->resolve($file);
        // если в обычных директориях не найден - ищем в simple
        if (is_null($filePath)) {
            $filePath = $resolver->resolve('simple/' . $file);
        }

        if (is_file($filePath) && is_readable($filePath)) {
            $currentFileTime = filemtime($filePath);
            if ($currentFileTime > $filemtime) {
                $filemtime = $currentFileTime;
            }
            $source .= file_get_contents($filePath);
        }
    }

    if (is_null($filemtime)) {
        header("HTTP/1.1 404 Not Found");
        header('Content-Type: text/html');
        exit();
    }

    return $source;
}
?>