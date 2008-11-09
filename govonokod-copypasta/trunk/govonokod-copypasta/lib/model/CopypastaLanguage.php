<?php

/**
 * Subclass for representing a row from the 'copypasta_language' table.
 *
 * 
 *
 * @package lib.model
 */ 
class CopypastaLanguage extends BaseCopypastaLanguage
{
  public function __toString() {
  	return $this->getTitle();
  }
  
}
