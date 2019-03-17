<?php 
	$config = $this->registry->get('config');

	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,9)+substr(md5($heading_title),0,3);

	$themeConfig = (array)$config->get('themecontrol');
	$theme  = $config->get('config_template');

	$listingConfig = array(
		'category_pzoom'                     => 1,
		'quickview'                          => 0,
		'show_swap_image'                    => 0,
		'product_layout'					 => 'default',
		'enable_paneltool'					=> 0	
	);


	$listingConfig     = array_merge($listingConfig, $themeConfig );
	$categoryPzoom 	    = $listingConfig['category_pzoom'];
	$quickview          = $listingConfig['quickview'];
	$swapimg            = $listingConfig['show_swap_image'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
	
	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	} 


	$productLayout = DIR_TEMPLATE.$config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	
	$productLayout = DIR_TEMPLATE.$config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';

    $button_compare = $objlang->get("button_compare");
?>
<div class="container">
	<div class="<?php echo $prefix;?> box productcarousel box-normal" id="module<?php echo $id; ?>">
		<div class="box-heading"><h4><span><?php echo $heading_title; ?></span></h4></div>
		<div class="box-content" >
			<div class="box-products slide" id="productcarousel-<?php echo $id;?>">
				<?php $pages = array_chunk( $products, $itemsperpage); ?>	
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
					<?php foreach( $tproducts as $i => $product ) { ?>
							<div class="product-col">
								<?php require( $productLayout );  ?>   
							</div>
					<?php } //endforeach; ?>
				<?php } ?>
			</div>
		</div>
	</div>
</div>
