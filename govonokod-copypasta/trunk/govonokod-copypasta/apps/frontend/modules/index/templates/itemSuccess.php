<h2 class="green"><?php echo __('Posted by %1% at %2%', array('%1%' => $copypasta->getUsername(), '%2%' => $copypasta->getCreatedAt()))?></h2>
<?php echo $highlighter->parse_code() ?>

<h2 class="green"><?php echo __('Submit a correction or amendment below.')?></h2>
<form action="<?php echo url_for('index/index') ?>" method="post">
<table class="w100">
  <colgroup>
    <col style="width: 130px;" />
    <col/>
  </colgroup>
  <tfoot>
    <tr>
      <td colspan="2">
        <label><input type="checkbox" id="remember"  name="remember" <?php echo ($remember != null ? 'checked="checked"' : '')?> /> <?php echo __('Remember me')?></label><br/>
        <input type="submit" value="Отправить" id="submit" />
      </td>
    </tr>
  </tfoot>
  <tbody>
    <?php echo $form; ?>
  </tbody>
</table>
</form>