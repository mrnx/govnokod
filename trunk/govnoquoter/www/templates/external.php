<?php
$pathToTemplates = dirname(__FILE__);
if (isset($_GET['type']) && isset($_GET['files'])) {
    //header("HTTP/1.1 304 Not Modified");
    $files = explode(',', $_GET['files']);
    if ($files) {
        switch ($_GET['type']) {
            case 'js':
                header('Content-type: application/x-javascript');
                $source = generateSource($files, $pathToTemplates . DIRECTORY_SEPARATOR . 'js', 'js');
                break;

            case 'css':
                header('Content-type: text/css');
                $source = generateSource($files, $pathToTemplates . DIRECTORY_SEPARATOR . 'css', 'css');
                break;

            default:
                $source = null;
                break;
        }

        echo $source;
        exit;
    }
}

function generateSource(Array $files, $path, $validExt) {
    $fileNameReplacePatterns = array(
        '..' => ''
    );
    $source = null;
    $filemtime = null;
    foreach ($files as $file) {
        $file = str_replace(array_keys($fileNameReplacePatterns), $fileNameReplacePatterns, $file);
        $ext = substr(strrchr($file, '.'), 1);
        if ($ext == $validExt) {
            $filePath = $path . DIRECTORY_SEPARATOR . $file;
            if (is_file($filePath) && is_readable($filePath)) {
                $currentFileTime = filemtime($filePath);
                if ($currentFileTime > $filemtime) {
                    $filemtime = $currentFileTime;
                }
                $source .= file_get_contents($filePath);
            }
        }
    }

    if ($files && $filemtime) {
        $etag = generateEtag($files, $filemtime);
        header('ETag: ' . $etag);
    }

    return $source;
}

function generateEtag(Array $files, $filemtime)
{
    $etag = md5(implode(',', $files) . $filemtime);
    $etag[8] = '-';
    $etag[13] = '-';
    $etag[17] = '-';
    $etag[21] = '-';

    return $etag;
}

?>