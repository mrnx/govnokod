<form action="<?php echo url_for('index/index') ?>" method="post">
<table>
  <tfoot>
    <tr>
      <td colspan="2">
        <input type="submit" value="Отправить" />
      </td>
    </tr>
  </tfoot>
  <tbody>
	  <?php echo $form; ?>
  </tbody>
</table>
</form>