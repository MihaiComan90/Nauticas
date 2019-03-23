<?php $olang = $this->registry->get('language'); ?>
<div class="product-filter clearfix">
  <div class="display">
    <span><?php echo $olang->get('Tip afisare'); ?></span>
    <div class="btn-group group-switch">
      <button type="button" id="list-view" class="btn-switch list" data-toggle="tooltip" title="<?php echo $button_list; ?>"><span class="fa fa-th-list"></span></button>
      <button type="button" id="grid-view" class="btn-switch grid" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><span class="fa fa-th-large"></span></button>
    </div>
  </div>
  <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
  <div class="sort hidden-xs"><span><?php echo $text_sort; ?></span>
    <select id="input-sort" onchange="location = this.value;" class="form-filter">
      <?php foreach ($sorts as $sorts) { ?>
      <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
      <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>
  <div class="limit hidden-xs"><span><?php echo $text_limit; ?></span>
    <select id="input-limit" onchange="location = this.value;" class="form-filter">
      <?php foreach ($limits as $limits) { ?>
      <?php if ($limits['value'] == $limit) { ?>
      <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>
</div> 
 
