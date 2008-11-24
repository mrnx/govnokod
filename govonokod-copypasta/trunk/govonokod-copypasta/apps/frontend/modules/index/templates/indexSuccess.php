<form action="<?php echo url_for('index/index') ?>" method="post">
<table>
  <tfoot>
    <tr>
      <td colspan="2">
        <label><input type="checkbox" name="remember" <?php echo ($remember != null ? 'checked="checked"' : '')?> /> <?php echo __('Remember me')?></label>
        <input type="submit" value="<?php echo  __('Submit') ?>" />
      </td>
    </tr>
  </tfoot>
  <tbody>
	  <?php echo $form; ?>
  </tbody>
</table>
</form>