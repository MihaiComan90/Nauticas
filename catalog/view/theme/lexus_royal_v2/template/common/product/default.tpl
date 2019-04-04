<?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');   ?>
<div class="product-block item-default mb-5" itemtype="http://schema.org/Product" itemscope>
	<div class="group-item mb-4">
		<?php if ($product['thumb']) {    ?>
		<div class="product-image image">
			<?php if( $product['special'] ) {   ?>
			<div class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></div>
			<?php } ?>
			<div class="image-container">
				<a href="<?php echo $product['href']; ?>" class="img front"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
			</div>
			
			<a class="fa fa-heart-o add-to-wishlist" href="javascript:;" onclick="wishlist.addwishlist('<?php echo $product['product_id']; ?>');"  title="<?php echo $objlang->get("button_wishlist"); ?>" ></a>
		</div>
		<?php } ?>
	</div>
	<div class="product-meta">
		<h3 class="product-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
		<?php if ( isset( $product['rating']) ) { ?>
		<div class="rating text-center">
			<?php for ($is = 1; $is <= 5; $is++) { ?>
				<?php if ($product['rating'] < $is) { ?>
					<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
				<?php } else { ?>
					<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
				<?php } ?>
			<?php } ?>
		</div>
		<?php } ?>
	</div>
	
	<?php if ($product['price']) { ?>
	<div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
		<?php if (!$product['special']) {  ?>
		<span class="special-price"><?php echo $product['price']; ?></span>
		<?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
		<meta content="<?php echo $p[0]; ?>" itemprop="price">
		<?php } ?>
		<?php } else { ?>
		<span class="price-old"><?php echo $product['price']; ?></span>
		<span class="price-new"><?php echo $product['special']; ?></span>				 
		<?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
		<meta content="<?php echo $p[0]; ?>" itemprop="price">
		<?php } ?>
		<?php } ?>
		<meta content="<?php // echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
	</div>
	<?php } ?>
</div>