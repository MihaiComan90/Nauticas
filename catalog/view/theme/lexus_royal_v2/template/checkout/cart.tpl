<?php echo $header; ?>
<div class="container mn">
    <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
   <section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content"><?php echo $content_top; ?>
  <?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>
    <div class="row">
      <div class="col-12 col-md-8">
        <h3 class="cart-title"><?php echo $heading_title; ?>
          <!--
          <?php if ($weight) { ?>
          &nbsp;(<?php echo $weight; ?>)
          <?php } ?>
          -->
        </h3>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <div class="cart-table">
            <table class="table">
              <thead>
                <tr>
                  <td class="text-center">&nbsp;</td>
                  <td class="text-left"><?php echo $column_name; ?></td>
                  <td class="text-right d-none d-md-table-cell d-lg-table-cell"><?php echo $column_price; ?></td>
                  <td class="text-right d-none d-md-table-cell d-lg-table-cell"><?php echo $column_total; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($products as $product) { ?>
                <tr>
					<!-- Product image -->
                  	<td class="text-center">
					  	<?php if ($product['thumb']) { ?>
                    		<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="" /></a>
                    	<?php } ?>
					</td>
					<!-- Product name -->
                  	<td class="text-left">
                    	<a href="<?php echo $product['href']; ?>" class="mb-3 d-block"><?php echo $product['name']; ?></a>
						<p class="m-0">
							<span><?php echo $column_model; ?>: </span><strong><?php echo $product['model']; ?></strong>
						</p>
						<?php if (!$product['stock']) { ?>
							<span class="text-danger">***</span>
						<?php } ?>
						<?php if ($product['option']) { ?>
							<?php foreach ($product['option'] as $option) { ?>
								<br />
								<small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
							<?php } ?>
						<?php } ?>
						<?php if ($product['reward']) { ?>
						<br />
						<small><?php echo $product['reward']; ?></small>
						<?php } ?>
						<?php if ($product['recurring']) { ?>
						<br />
						<span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
						<?php } ?>
						<p class="d-lg-none m-0">
							<span><?php echo $column_price; ?>:</span> <strong><?php echo $product['price']; ?></strong>
						</p>
						<p class="d-lg-none m-0">
							<span><?php echo $column_total; ?>:</span> <strong><?php echo $product['total']; ?></span>
						</p>
					</td>
                  	<td class="text-right d-none d-md-table-cell d-lg-table-cell"><?php echo $product['price']; ?></td>
                  	<td class="text-right d-none d-md-table-cell d-lg-table-cell"><?php echo $product['total']; ?></td>
                </tr>
				<tr>
					<td class="d-none d-md-table-cell" style="border: none">&nbsp;</td>
					<td colspan="4">
						<div class="row">
							<div class="col-12 col-md-9 mb-3">
								<div class="input-group">
									<input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control text-center" />
									<span class="input-group-append">
										<button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="button btn btn-secondary">Actualizeaza cantitatea</button>
									</span>
								</div>
							</div>

							<div class="col-12 col-md-3">
								<button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="button btn btn-secondary btn-block" onclick="cart.remove('<?php echo $product['key']; ?>');">Elimina din cos</button>
								</div>
							</div>
						</div>
					</td>
					<!--
					<td colspan="2">&nbsp;</td>
					-->
				</tr>
                <?php } ?>
                <?php foreach ($vouchers as $vouchers) { ?>
                <tr>
                  <td></td>
                  <td class="text-left"><?php echo $vouchers['description']; ?></td>
                  <td class="text-left"></td>
                  	<td class="text-left">
						<div class="input-group btn-block" style="max-width: 200px;">
							<input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
							<span class="input-group-btn">
								<button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn button" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i>
								</button>
							</span>
						</div>
					</td>
                  <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                  <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
      </div>
      <div class="col-12 col-md-4">
        <h3 class="cart-title">Sumar cos cumparaturi</h3>
        <table class="table order-summary">
          <?php foreach ($totals as $total) { ?>
          <tr>
            <td class="text-left"><?php echo $total['title']; ?>:</td>
            <td class="text-right"><?php echo $total['text']; ?></td>
          </tr>
          <?php } ?>
        </table>
        <div class="buttons checkout-actions">
          <a href="<?php echo $checkout; ?>" class="btn btn-primary btn-block"><?php echo $button_checkout; ?></a>
          <div class="divider">
            <hr />
            <span>sau</span>
          </div>
          <a href="<?php echo $continue; ?>" class="btn btn-link btn-block"><?php echo $button_shopping; ?></a>
        </div>

        <?php if ($coupon || $voucher || $reward || $shipping) { ?>
        <div class="checkout-discounts">
          <?php echo $coupon; ?>
          <?php echo $voucher; ?>
          <?php echo $reward; ?> 
          <?php /* echo $shipping; */ ?>
        </div>
        <?php } ?>
      </div>
    </div>
      <?php echo $content_bottom; ?>
    </div>
   </section> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
<?php echo $footer; ?> 