<?php
fileLoader::load('exceptions/mzzOpenIDException');

class mzzOpenID
{

    protected $identity;
    protected $trustRoot;
    protected $approvedURL;
    protected $openIDServer = null;

    protected $delegates = array();

    protected $fields = array(
        'required' => array(),
        'optional' => array()
    );

    /*
    public function __construct()
    {
    }
    */

    public function setIdentity($identity)
    {
        if ((stripos($identity, 'http://') === false) && (stripos($identity, 'https://') === false)) {
            $identity = 'http://' . $identity;
        }

        if (preg_match('|^http[s]?://[^/]+$|', $identity)) {
            $identity .= '/';
        }

        $this->identity = $identity;
    }

    public function setTrustRoot($trustRoot)
    {
        $this->trustRoot = $trustRoot;
    }

    public function setApprovedUrl($approvedUrl)
    {
        $this->approvedUrl = $approvedUrl;
    }

    public function setRequiredFields(Array $fields)
    {
        $this->fields['required'] = $fields;
    }

    public function setOptionalFields(Array $fields)
    {
        $this->fields['optional'] = $fields;
    }

    public function getOpenIDServer()
    {
        if (is_null($this->openIDServer)) {
            $request = $this->request($this->identity);
            echo '<pre>' . $request . '</pre>';
            exit;
        }

        return $this->openIDServer;
    }

    public function getRedirectUrl()
    {

    }

    protected function request($url)
    {
        fileLoader::load('service/mzzCurl');
        $curl = new mzzCurl($url);
        $curl->setOpt(CURLOPT_FOLLOWLOCATION, true);
        $curl->setOpt(CURLOPT_TIMEOUT, 15);

        try {
            $response = $curl->exec();
        } catch (mzzCurlException $e) {
            throw new mzzOpenIDException($e->getMessage(), $e->getCode());
        }

        return $response;
    }
}
?>