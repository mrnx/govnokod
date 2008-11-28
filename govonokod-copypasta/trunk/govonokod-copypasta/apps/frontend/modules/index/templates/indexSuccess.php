<form action="<?php echo url_for('index/index') ?>" method="post">
<table class="w100">
  <colgroup>
    <col style="width: 130px;" />
    <col/>
  </colgroup>
  <tfoot>
    <tr>
      <td colspan="2">
        <label><input type="checkbox" id="remember" name="remember" <?php echo ($remember != null ? 'checked="checked"' : '')?> /> <?php echo __('Remember me')?></label><br />        
        <input type="submit" value="<?php echo  __('Submit') ?>" id="submit" />
      </td>
    </tr>
  </tfoot>
  <tbody>
	  <?php echo $form; ?>
  </tbody>
</table>
</form>