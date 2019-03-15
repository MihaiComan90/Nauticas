<?php
	$span = floor(12/$cols);
?>
<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?> 
<?php echo $header; ?>
<div class="container">
	
	<div class="row">
    <?php if( $SPAN[0] ): ?>
		<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
			<?php echo $column_left; ?>
		</aside>	
	<?php endif; ?>
	<section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
	<?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>  
		<div id="content"><?php echo $content_top; ?>			
			<h3><?php echo $objlang->get('deal_option'); ?></h3>
		<div class="box productdeals list-deals">
			<!-- Deal Option -->
			<ul class="box-heading nav nav-tabs">
				<?php foreach ($head_titles as $item): ?>
				<?php if ($item['active']): ?>
				<li class="active"><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
				<?php else: ?>
				<li><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
				<?php endif; ?>
				<?php endforeach; ?>
			</ul>
		<div class="box-content">
			<div class="product-filter clearfix">
				<div class="limit">
					<b class="hide"><?php echo $objlang->get('text_limit'); ?></b>
					<select id="input-limit" class="form-filter" onchange="location = this.value;">
						<?php foreach ($limits as $limits) { ?>
						<?php if ($limits['value'] == $limit) { ?>
						<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</div>
				<div class="sort">
					<b class="hide"><?php echo $objlang->get('text_sort'); ?></b>
					<select id="input-sort" class="form-filter" onchange="location = this.value;">
						<?php foreach ($sorts as $sorts) { ?>
						<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
						<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</div>
				<div class="category">
					<b class="hide"><?php echo $objlang->get('text_category'); ?></b>
					<select id="input-category" class="form-filter" name="category_id" onchange="location = this.value;">
						<option value="<?php echo $href_default;?>"><?php echo $objlang->get("text_category_all"); ?></option>
						<?php foreach ($categories as $category_1) { ?>
						<?php if ($category_1['category_id'] == $category_id) { ?>
						<option value="<?php echo $category_1['href']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></option>
						<?php } ?>
						<?php foreach ($category_1['children'] as $category_2) { ?>
						<?php if ($category_2['child_id'] == $category_id) { ?>
						<option value="<?php echo $category_2['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_2['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
						<?php } ?>

						<?php if (isset($category_2['children'])) { ?>
						<?php foreach ($category_2['children'] as $category_3) { ?>
						<?php if ($category_3['child_id'] == $category_id) { ?>
						<option value="<?php echo $category_3['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_3['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
						<?php } ?>
						<?php } //endforeach categories_2?>
						<?php } //endif endforeach categories_2?>

						<?php } //endforeach categories_1?>
						<?php } //endforeach categories_0?>
					</select>
				</div>
			</div>
			<!-- Fillter Product -->
			<div class="product-grid">
				<?php if (count($products) > 0): ?>
				<?php foreach( $products as $i => $product ):  $i=$i+1;?>
					<?php if( $i%$cols == 1 || $cols == 1): ?>
					<div class="row">
					<?php endif; ?>
						<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-cols">

							<div class="product-block">
								<?php if ($product['thumb']): ?>
								<div class="image">
									<?php if( $product['special'] ):  ?>									
										<div class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></div>
									<?php endif; ?>
									<a href="<?php echo $product['href']; ?>">
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
									</a>
								</div>
								<?php endif; ?>
									<div class="product-meta">
										<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
										<!-- <p><?php echo $product['description']; ?></p> -->
										<?php if ($product['rating']) { ?>
										<div class="rating">
											<?php for ($i = 1; $i <= 5; $i++) { ?>
											<?php if ($product['rating'] < $i) { ?>
											<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
											<?php } else { ?>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
											<?php } ?>
											<?php } ?>
										</div>
										<?php } ?>
										<div class="triangle-bottomleft cart">											
											<button class="addtocart" type="button" value="<?php echo $objlang->get("button_cart"); ?>" onclick="cart.addcart('<?php echo $product['product_id']; ?>');"><span><?php echo $objlang->get("button_cart"); ?></span></button>
										</div>

										<div class="group-deals"><!-- count down -->
											<div id="item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>" class="item-countdown"></div>
											<script type="text/javascript">
												jQuery(document).ready(function($){
													$("#item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>").lofCountDown({
														formatStyle:2,
														TargetDate:"<?php echo date('m/d/Y G:i:s', strtotime($product['date_end_string'])); ?>",
														DisplayFormat:"<ul><li>%%D%% <div><?php echo $objlang->get("text_days");?></div></li><li> %%H%% <div><?php echo $objlang->get("text_hours");?></div></li><li> %%M%% <div><?php echo $objlang->get("text_minutes");?></div></li><li> %%S%% <div><?php echo $objlang->get("text_seconds");?></div></li></ul>",
														FinishMessage: "<?php echo $objlang->get('text_finish');?>"
													});
												});
											</script>
											<div class="deal-collection hidden">																					
												<div class="deal_detail">
													<ul>
														<li>
															<span><?php echo $objlang->get("text_discount");?></span>
															<span class="deal_detail_num"><?php echo $product['deal_discount'];?>%</span>
														</li>
														<li>
															<span><?php echo $objlang->get("text_you_save");?></span>
															<span class="deal_detail_num"><span class="price"><?php echo $product["save_price"]; ?></span></span>
														</li>
														<li>
															<span><?php echo $objlang->get("text_bought");?></span>
															<span class="deal_detail_num"><?php echo $product['bought'];?></span>
														</li>
													</ul>
												</div>
												<div class="deal-qty-box">
													<?php echo sprintf($objlang->get("text_quantity_deal"), $product["quantity"]);?>
												</div>

												<div class="item-detail">
													<div class="timer-explain">(<?php echo date($objlang->get("date_format_short"), strtotime($product['date_end_string'])); ?>)</div>
												</div>
											</div>
										</div>
									</div>
									<div class="triangle-righttop action">
								    	<div class="action-inner">
										  	<div class="wishlist">
											  <a class="fa fa-heart" onclick="wishlist.addwishlist('<?php echo $product['product_id']; ?>');"  title="<?php echo $objlang->get("button_wishlist"); ?>" ><span><?php echo $objlang->get("button_wishlist"); ?></span></a>
											</div>
											<div class="compare">
											  <a class="fa fa-retweet" onclick="compare.addcompare('<?php echo $product['product_id']; ?>');" title="<?php echo $objlang->get("button_compare"); ?>" ><span><?php echo $objlang->get("button_compare"); ?></span></a>
											</div>
										</div>
									</div>
									<?php if ($product['price']) { ?>
									<p class="price">
										<?php if (!$product['special']) { ?>
										<?php echo $product['price']; ?>
										<?php } else { ?>
										<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
										<?php } ?>
										<?php if (!empty($product['tax'])) { ?>
										<span class="price-tax"><?php echo $objlang->get('text_tax'); ?> <?php echo $product['tax']; ?></span>
										<?php } ?>
									</p>
									<?php } ?>
							</div>							
						</div>
					<?php if($i%$cols == 0): ?>
					</div>
					<?php endif; ?>

					<?php endforeach; ?>
			</div>
		</div>
		</div>
			<!-- pagination -->
			<div class="row">
				<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
				<div class="col-sm-6 text-right"><?php echo $results; ?></div>
			</div>
			<?php endif; ?>

			<div class="row">
				<?php if (empty($products)): ?>
				<div class="col-sm-6 text-left"><?php echo $objlang->get('text_not_empty');?></div>
				<div class="col-sm-6 text-right">
					<div class="buttons">
						<div class="pull-right"><a href="<?php echo $objurl->link('common/home'); ?>" class="button"><?php echo $objlang->get('button_continue'); ?></a></div>
					</div>
				</div>
				<?php endif; ?>
			</div>

			<?php echo $content_bottom; ?>			
		</div><!-- end div #content -->
		</section>
		<?php if( $SPAN[2] ): ?>
			<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
				<?php echo $column_right; ?>
			</aside>
		<?php endif; ?>
	</div><!-- end div .row -->
</div><!-- end div .container -->
<?php echo $footer; ?>
