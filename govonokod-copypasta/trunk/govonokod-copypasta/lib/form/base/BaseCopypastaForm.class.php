<?php

/**
 * Copypasta form base class.
 *
 * @package    form
 * @subpackage copypasta
 * @version    SVN: $Id: sfPropelFormGeneratedTemplate.php 8807 2008-05-06 14:12:28Z fabien $
 */
class BaseCopypastaForm extends BaseFormPropel
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'                    => new sfWidgetFormInputHidden(),
      'copypasta_language_id' => new sfWidgetFormPropelSelect(array('model' => 'CopypastaLanguage', 'add_empty' => true)),
      'copypasta'             => new sfWidgetFormTextarea(),
      'username'              => new sfWidgetFormInput(),
      'delete_at'             => new sfWidgetFormDateTime(),
      'created_at'            => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'                    => new sfValidatorPropelChoice(array('model' => 'Copypasta', 'column' => 'id', 'required' => false)),
      'copypasta_language_id' => new sfValidatorPropelChoice(array('model' => 'CopypastaLanguage', 'column' => 'id', 'required' => false)),
      'copypasta'             => new sfValidatorString(array('required' => false)),
      'username'              => new sfValidatorString(array('max_length' => 50, 'required' => false)),
      'delete_at'             => new sfValidatorDateTime(array('required' => false)),
      'created_at'            => new sfValidatorDateTime(array('required' => false)),
    ));

    $this->widgetSchema->setNameFormat('copypasta[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    parent::setup();
  }

  public function getModelName()
  {
    return 'Copypasta';
  }


}
