<h2 class="green"><?php echo __('Posted by %1% at %2%', array('%1%' => $copypasta->getUsername(), '%2%' => $copypasta->getCreatedAt()))?></h2>
<pre><code><?php echo $copypasta->getCopypasta() ?>
</code></pre>

<h2 class="green"><?php echo __('Submit a correction or amendment below.')?></h2>
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