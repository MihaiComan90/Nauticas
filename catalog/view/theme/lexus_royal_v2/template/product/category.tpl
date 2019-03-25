<?php 

 $helper =  ThemeControlHelper::getInstance( $this->registry );

echo $header; ?>

<div class="container">
    <?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>
</div>

<div class="container mn">
  <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?> 

  <div class="row">
    <?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
        <?php if( true &&  $categories = $helper->getCategoriesById() ){   ?>
          <div class="panel panel-default category-list d-none d-md-block">
          <div class="list-group">
          <div class="list-box">
            <a class="list-group-item">
              <?php echo $text_refine; ?>
            </a> 
            <div class="list-group-item">
              <div class="list-box">  
              <?php foreach( $categories as $category ) {  ?>
                <?php if( $category['thumb'] ){ ?>
                    <div class="image">
                        <a href="<?php echo $category['href']; ?>">
                          <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" class="img-responsive" />
                        </a>
                    </div>
                <?php } ?>
                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
              <?php } ?>
              </div>	       
            </div>
          </div>
          </div>
          </div>
          <?php } else if ($categories) { ?>
            <div class="refine-search">
            <h3><?php echo $text_refine; ?></h3>
              <?php if (count($categories) <= 5) { ?>
              <div class="row">
                <div class="col-sm-3">
                  <ul>
                    <?php foreach ($categories as $category) { ?>
                    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                    <?php } ?>
                  </ul>
                </div>
              </div>
              <?php } else { ?>
              <div class="row">
                <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
                <div class="col-sm-3">
                  <ul>
                    <?php foreach ($categories as $category) { ?>
                    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                    <?php } ?>
                  </ul>
                </div>
                <?php } ?>
              </div>
              <?php } ?>
          </div>    
        <?php } ?>
        <!-- Filtres -->
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 

    <section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">     
      <div id="content"><?php echo $content_top; ?>
      <?php if ($thumb || $description) { ?>
      <div class="category-info clearfix hidden-xs hidden-sm">
        <?php if ($thumb) { ?>
          <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" /></div>
        <?php } ?>
      </div>
      <?php } ?>
    <h1 class="heading-title">
      <span class="title"><?php echo $heading_title; ?></span>
    </h1>
      <?php if ($products) { ?>
      <?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
      <?php } ?>
        <?php if (!$categories && !$products) { ?>
        <div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
        <div class="buttons">
          <div class="right"><a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
      <?php echo $content_bottom; ?></div>
   </section> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>
</div>
</div>
<?php echo $footer; ?>