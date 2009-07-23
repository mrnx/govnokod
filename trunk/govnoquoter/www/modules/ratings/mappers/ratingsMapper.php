<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2008
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('ratings');

/**
 * ratingsMapper: маппер
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */
class ratingsMapper extends mapper
{
    const RATED_TABLE_POSTFIX = '_ratings';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'ratings';
    protected $table = '';

    protected $ratedMapper = null;
    protected $rateDriver = null;

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated'
        ),
        'ip_address' => array(
            'accessor' => 'getIpAddress',
            'mutator' => 'setIpAddress'
        ),
        'useragent' => array(
            'accessor' => 'getUserAgent',
            'mutator' => 'setUserAgent'
        ),
        'ratevalue' => array(
            'accessor' => 'getRateValue',
            'mutator' => 'setRateValue'
        ),
        'parent_id' => array(
            'accessor' => 'getParent',
            'mutator' => 'setParent'
        )
    );

    public function setRatedMapper(mapper $mapper)
    {
        if (!$mapper->isAttached('ratings')) {
            throw new mzzRuntimeException('Attach a ratingsPlugin for ' . get_class($mapper) . '!');
        }

        $this->ratedMapper = $mapper;
        $this->table = $mapper->table() . self::RATED_TABLE_POSTFIX;
    }

    public function getRatedMapper()
    {
        return $this->ratedMapper;
    }

    public function setRateDriver($driver)
    {
        $this->rateDriver = (string)$driver;
    }

    public function getRateDriver()
    {
        return $this->rateDriver;
    }

    public function preInsert(array & $data)
    {
        $data['created'] = time();
    }

    public function convertArgsToObj($args)
    {
    }
}

?>