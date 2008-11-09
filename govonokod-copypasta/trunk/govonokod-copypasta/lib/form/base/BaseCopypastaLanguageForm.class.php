<?php

/**
 * CopypastaLanguage form base class.
 *
 * @package    form
 * @subpackage copypasta_language
 * @version    SVN: $Id: sfPropelFormGeneratedTemplate.php 8807 2008-05-06 14:12:28Z fabien $
 */
class BaseCopypastaLanguageForm extends BaseFormPropel
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'       => new sfWidgetFormInputHidden(),
      'title'    => new sfWidgetFormInput(),
      'position' => new sfWidgetFormInput(),
    ));

    $this->setValidators(array(
      'id'       => new sfValidatorPropelChoice(array('model' => 'CopypastaLanguage', 'column' => 'id', 'required' => false)),
      'title'    => new sfValidatorString(array('max_length' => 50, 'required' => false)),
      'position' => new sfValidatorInteger(array('required' => false)),
    ));

    $this->widgetSchema->setNameFormat('copypasta_language[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    parent::setup();
  }

  public function getModelName()
  {
    return 'CopypastaLanguage';
  }


}
