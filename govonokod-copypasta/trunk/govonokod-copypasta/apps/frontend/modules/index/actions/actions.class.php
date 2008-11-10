<?php

/**
 * index actions.
 *
 * @package    govnokod
 * @subpackage index
 * @author     Your name here
 * @version    SVN: $Id: actions.class.php 9301 2008-05-27 01:08:46Z dwhittle $
 */
class indexActions extends sfActions
{
 /**
  * Executes index action
  *
  * @param sfRequest $request A request object
  */
  public function executeIndex($request)
  {
  	$form = new CopypastaForm();
  	if ($request->isMethod('post'))
  	{
  		$form->bind($request->getParameter('copypasta'));
  		if ($form->isValid())
  		{
  			$copypasta = $form->save();
  			$this->redirect('index/item?id='.$copypasta->getId());
  		}
  	}
  	
    $this->form = $form;
  }

 /**
  * Executes index action
  *
  * @param sfRequest $request A request object
  */
  public  function executeItem($request) {
  	$this->forward404Unless($copypasta = CopypastaPeer::retrieveByPK($request->getParameter('id')));
  	
  	$this->copypasta = $copypasta;
    $this->form      = new CopypastaForm($copypasta);
    $this->form->setDefault('username', '');
  }
  
}
