<div id="cart" class="position-relative dropdown">
	<div data-loading-text="<?php echo $text_loading; ?>" class="media-body heading">
		<a class="btn" href="<?php echo $shopping_cart; ?>"><span id="cart-total"><?php echo $text_items; ?></span></a>
	</div>
	<div class="minicart dropdown-menu">
		<?php if ($products || $vouchers) { ?>
			<!-- Product lineitem - product -->
			<div class="mini-cart-info">
				<?php foreach ($products as $product) { ?>
					<div class="lineitem row no-gutters">
						<!-- Product lineitem - image -->
						<div class="col-4 lineitem__product-image">
							<?php if ($product['thumb']) { ?>
								<a class="d-block" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-fluid" /></a>
							<?php } ?>	
						</div>
						<!-- Product lineitem - name / quantity / price per unit -->
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
								<!-- Product lineitem - total -->
								<div class="col-12 lineitem__product-total">
									<span><?php echo $text_price_unit; ?>:</span> <?php echo $product['total']; ?>
								</div>
							</div>
						</div>
						<!-- Product lineitem - remove product -->
						<div class="col-1 lineitem__product-remove d-flex flex-column justify-content-center">
							<button type="button" onclick="cart.remove('<?php echo $product['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-xs"><i class="fa fa-times"></i></button>
						</div>
					</div>
				<?php } ?>

				<?php foreach ($vouchers as $voucher) { ?>
					<div class="row">
						<!-- Voucher description -->
						<div class="col-3 lineitem__voucher-description">
							<?php echo $voucher['description']; ?>
						</div>
						<!-- Voucer quantity -->
						<div class="col-1">x&nbsp;1</div>
						<!-- Voucher amount -->
						<div class="col-3 lineitem__voucher-amount">
							<?php echo $voucher['amount']; ?>
						</div>
						<!-- Voucher remove -->
						<div class="col-3 lineitem__voucher-remove">
							<button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-xs"><i class="fa fa-times"></i></button>
						</div>
					</div>
				<?php } ?>
			</div>

			<!-- Mini Cart Totals -->
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
			<!-- Mini Cart Checkout -->
			<div class="minicart__checkout d-flex flex-row justify-content-between align-items-end">
				<a class="btn btn-inline btn-md btn-info btn-cart" href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a>
				<a class="btn btn-inline btn-md btn-primary btn-checkout" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
			</div>
		<?php } else { ?>
			<!-- Mini Cart - empty -->
			<div class="minicart__empty">
				<p><?php echo $text_empty; ?></p>
			</div>
		<?php } ?>
	</div>
</div>