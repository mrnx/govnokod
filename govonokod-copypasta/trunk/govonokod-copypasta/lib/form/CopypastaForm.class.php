<?php

/**
 * Copypasta form.
 *
 * @package    form
 * @subpackage copypasta
 * @version    SVN: $Id: sfPropelFormTemplate.php 6174 2007-11-27 06:22:40Z fabien $
 */
class CopypastaForm extends BaseCopypastaForm
{
  public function configure()
  {
  }
  public function setup()
  {
    parent::setup();
    $this->setWidgets(array(
      'id'                    => new sfWidgetFormInputHidden(),
      'copypasta_language_id' => new sfWidgetFormPropelSelect(array('model' => 'CopypastaLanguage', 'add_empty' => 'None')),
      'copypasta'             => new sfWidgetFormTextarea(),
      'username'              => new sfWidgetFormInput(),
      'delete_at'             => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'                    => new sfValidatorPropelChoice(array('model' => 'Copypasta', 'column' => 'id', 'required' => false)),
      'copypasta_language_id' => new sfValidatorPropelChoice(array('model' => 'CopypastaLanguage', 'column' => 'id', 'required' => false)),
      'copypasta'             => new sfValidatorString(array('required' => true)),
      'username'              => new sfValidatorString(array('max_length' => 50, 'required' => true)),
      'delete_at'             => new sfValidatorDateTime(array('required' => true)),
    ));
    
    $this->widgetSchema->setNameFormat('copypasta[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

  }
}
