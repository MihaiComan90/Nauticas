<div id="cart" class="position-relative dropdown">
	<div data-loading-text="<?php echo $text_loading; ?>" class="media-body heading">
		<a class="btn" href="<?php echo $shopping_cart; ?>"><span id="cart-total"><?php echo $text_items; ?></span></a>
	</div>
	<?php if ($products || $vouchers) { ?>
	<div class="minicart dropdown-menu">
			<div class="mini-cart-info">
				<?php foreach ($products as $product) { ?>
					<div class="lineitem row no-gutters">
						
						<div class="col-4 lineitem__product-image">
							<?php if ($product['thumb']) { ?>
								<a class="d-block" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-fluid" /></a>
							<?php } ?>	
						</div>
						
						<div class="col-7 lineitem__product-details d-flex flex-column justify-content-center">
							<div class="row">
								<div class="col-12">
									<a class="lineitem__product-name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
									<?php if ($product['option']) { ?>
										<?php foreach ($product['option'] as $option) { ?>
											<br />
											- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
										<?php } ?>
									<?php } ?>
									<?php if ($product['recurring']) { ?>
										<br />
										- <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
									<?php } ?>
								</div>
							</div>
							<div class="row">
								<div class="col-12 lineitem__product-model">
									<span><?php echo $text_model; ?>:</span> <?php echo $product['model']; ?>
								</div>
								<div class="col-12 lineitem__product-quantity">
									<span><?php echo $text_quantity; ?>:</span> <?php echo $product['quantity']; ?>
								</div>
							
								<div class="col-12 lineitem__product-total">
									<span><?php echo $text_price_unit; ?>:</span> <?php echo $product['total']; ?>
								</div>
							</div>
						</div>
						
						<div class="col-1 lineitem__product-remove d-flex flex-column justify-content-center">
							<button type="button" data-key="<?php echo $product['key']; ?>" data-url="index.php?route=checkout/cart/remove" title="<?php echo $button_remove; ?>" class="btn btn-xs remove"><i class="fa fa-times"></i></button>
						</div>
					</div>
				<?php } ?>

				<?php foreach ($vouchers as $voucher) { ?>
					<div class="row">
						
						<div class="col-3 lineitem__voucher-description">
							<?php echo $voucher['description']; ?>
						</div>
				
						<div class="col-1">x&nbsp;1</div>
						
						<div class="col-3 lineitem__voucher-amount">
							<?php echo $voucher['amount']; ?>
						</div>
						
						<div class="col-3 lineitem__voucher-remove">
							<button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-xs"><i class="fa fa-times"></i></button>
						</div>
					</div>
				<?php } ?>
			</div>
			
			<div class="mini-cart-total">
				<div class="minicart__total">
					<div class="row">
					<?php foreach ($totals as $key=>$total) { ?>
						<?php if($key === 1) { ?>
							<div class="col-12 text-right"><span><?php echo $text_minicart_total; ?>:</span> <span><?php echo $total['text']; ?></span></div>
						<?php } ?>
					<?php } ?>
					</div>
				</div>
			</div>
			
			<div class="minicart__checkout d-flex flex-row justify-content-between align-items-end">
				<a class="btn btn-inline btn-md btn-info btn-cart" href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a>
				<a class="btn btn-inline btn-md btn-primary btn-checkout" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
			</div>
	</div>
	<?php } ?>
</div>