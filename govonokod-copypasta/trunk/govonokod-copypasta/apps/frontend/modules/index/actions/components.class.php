<?php
 
class indexComponents extends sfComponents
{
  public function executeLastCopypastas()
  {
    $c = new Criteria();
    $c->addDescendingOrderByColumn(CopypastaPeer::CREATED_AT);
    $c->setLimit(10);
    $this->copypastas = CopypastaPeer::doSelect($c);
  }
}
 