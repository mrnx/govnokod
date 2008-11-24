<?php if (count($copypastas) > 0): ?>
  <h2 class="green"><?php echo __('Last copypastas') ?></h2>
  <ul>
  <?php foreach ($copypastas as $copypasta): ?>
    <li>
      <?php echo link_to(__('by').' '.$copypasta->getUsername(), 'index/item?id='.$copypasta->getId()) ?><br />
      <?php echo __('at %1%', array('%1%' => $copypasta->getCreatedAt()))?>
    </li>
  <?php endforeach; ?>
  </ul>
<?php endif; ?>