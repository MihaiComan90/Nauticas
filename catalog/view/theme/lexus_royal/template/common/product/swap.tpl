<?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');   ?>
<div class="product-block item-default" itemtype="http://schema.org/Product" itemscope>
	<div class="group-item">
		<?php if ($product['thumb']) {    ?>
		 <div class="image swap">
	      	<?php if( $product['special'] ) {   ?>
	    	<div class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></div>
	    	<?php } ?>
	    	<div class="image_container">
	    		<a href="<?php echo $product['href']; ?>" class="img front"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>

	    		<?php if( isset($product['thumb2']) ){ ?>
					<a class="img back hidden-sm hidden-xs" href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb2']; ?>" alt="<?php echo $product['name']; ?>"></a>
				<?php } ?>

	    	</div>
	    	<?php if ($quickview){ ?>
			<a class="iframe-link pav-colorbox hidden-sm hidden-xs" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"><span class='fa fa-eye'></span><?php echo $objlang->get('quick_view'); ?></a>
			<?php } ?>
			
			<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
	      		<a href="<?php echo $zimage;?>" class="info-view colorbox product-zoom hidden-xs hidden-sm" rel="nofollow" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
	      	<?php } ?>
		</div>
		<?php } ?>
	</div>
	<div class="product-meta">
		<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
		<?php if( isset($product['description']) ){ ?> 
			<div class="description" itemprop="description"><?php echo utf8_substr( strip_tags($product['description']),0,250);?>...</div>
		<?php } ?>

		<?php if ( isset( $product['rating']) ) { ?>
          <div class="rating">
            <?php for ($is = 1; $is <= 5; $is++) { ?>
            <?php if ($product['rating'] < $is) { ?>
            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
            <?php } else { ?>
            <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
            <?php } ?>
            <?php } ?>
          </div>
        <?php } ?>

		<div class="triangle-bottomleft cart">
			<?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
				<button class="addtocart" type="button" value="<?php echo $objlang->get("button_cart"); ?>" onclick="cart.addcart('<?php echo $product['product_id']; ?>');"><span><?php echo $objlang->get("button_cart"); ?></span></button>
			<?php } ?>
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





