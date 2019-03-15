<?php
$objlang = $this->registry->get('language');
?>
<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   <div id="pavtestimonial<?php echo $id;?>" class="box nobackground carousel slide pavtestimonial">
   	<div class="box-heading"><span class="headding-title"><?php echo $objlang->get("text_testimonial");?></span></div>
		<div class="carousel-inner">
			 <?php $pages = array_chunk($testimonials, $row ); ?>
			 <?php foreach ( $pages as $i => $testimonials ) { ?>
				<div class="item <?php if($i==0) {?>active<?php } ?>">
					 <?php foreach ($testimonials as $i => $testimonial) { ?>
					<div class="testimonial-wrapper clearfix">
		 				<div class="testimonial-item">
		 					<div class="t-avatar pull-left"><img  alt="<?php echo strip_tags($testimonial['profile']); ?>" src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/></div>
		 					<?php if(  $testimonial['profile'] ) { ?>
							<div class="profile">
								<?php echo $testimonial['profile']; ?>
							</div>
							<?php } ?>
							<?php if(  $testimonial['description'] ) { ?>
							<div class="testimonial">
								<?php echo $testimonial['description']; ?>
								<?php if( $testimonial['video_link']) { ?>
								<a class="colorbox-t" href="<?php echo $testimonial['video_link'];?>"><?php echo $objlang->get('text_watch_video_testimonial');?></a>
								<?php } ?>
							</div>
							<?php } ?>						
						</div>
					</div>
					<?php } ?>
				</div>
			<?php } ?>
		</div>
	 		
		<?php if( count($pages) > 1 ){ ?>
		<div class="carousel-controls">	
			<a class="carousel-control left fa fa-angle-left" href="#pavtestimonial<?php echo $id;?>" data-slide="prev"></a>
			<a class="carousel-control right fa fa-angle-right" href="#pavtestimonial<?php echo $id;?>" data-slide="next"></a>
		</div>
		<?php } ?>
    </div>
	<?php if( count($pages) > 1 ){ ?>
	<script type="text/javascript">
	<!--
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
	-->
	</script>
	<?php } ?>
<?php } ?>
