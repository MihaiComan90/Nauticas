<?php 
	$span = 12/$cols; 
?>

<?php if( !empty($blogs) ) { ?>
<div class="box ">
	<div class="box-heading"><span class="headding-title"><?php echo $heading_title; ?></span></div>
	<div class="box-content" >
<div id="blog-carousel" class="box-products slide" data-ride="carousel">
  <!-- Wrapper for slides -->
	<div class="carousel-controls">
		<a class="carousel-control left fa fa-angle-left" href="#blog-carousel" data-slide="prev"></a>
		<a class="carousel-control right fa fa-angle-right" href="#blog-carousel" data-slide="next"></a>
	</div>
    <div class="carousel-inner">
	  <?php foreach( $blogs as $key => $blog ) { ?>

	    <div class="item <?php echo ($key==0)?'active':''?>">
			<?php if( $blog['thumb']  )  { ?>
			<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt=""/>
			<?php } ?>
			<div class="group-blog">
				<h4 class="blog-title">
					<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
				</h4>
				<div class="description"><?php $blog['description'] = strip_tags($blog['description']); ?>
				<?php echo utf8_substr( $blog['description'],0, 200)."...";?></div>
				<p><a href="<?php echo $blog['link'];?>" class="readmore"><?php echo $objlang->get('text_readmore');?></a></p>
			</div>
	    </div>

	  <?php } ?>  
	</div>
  <!-- Controls -->
</div>
	</div>
 </div>
<?php } ?>

<script>
$('.carousel').carousel({interval:false,auto:false,pause:'hover'});
</script>

