<article class="blog-item row">	
	<?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
	<div class="col-lg-12">
		<figure class="blog-body image">									
			<a href="<?php echo $blog['link'];?>">
				<img src="<?php echo $blog['thumb_small'];?>" title="<?php echo $blog['title'];?>" alt="" class="img-responsive" />
			</a>
		</figure>		
	</div>	
	<?php } ?>	
			
	
	<?php if( $config->get('cat_show_title') ) { ?>
	
	<div class="col-lg-12">
		<header class="blog-header clearfix">
<!-- 		<?php if( $config->get('cat_show_created') ) { ?>
			<span class="created">
				<i class="fa fa-clock-o">   <?php echo $objlang->get("text_created");?> :</i>
				<?php echo date("d-M-Y",strtotime($blog['created']));?>
			</span>
		<?php } ?> -->
		<h4 class="blog-title"><a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h4>
		<?php } ?>
		</header>
	
	
		<footer>	
			<div class="blog-meta">
				<?php if( $config->get('cat_show_author') ) { ?>
				<span class="author"><span><i class="fa fa-pencil"></i><?php echo $objlang->get("text_write_by");?></span> <?php echo $blog['author'];?></span>
				<?php } ?>
				
				<?php if( $config->get('cat_show_category') ) { ?>
				<span class="publishin">
					<span><i class="fa fa-gavel"></i><?php echo $objlang->get("text_published_in");?></span>
					<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
				</span>
				<?php } ?>
				
				<?php if( $config->get('cat_show_hits') ) { ?>
				<span class="hits"><span><i class="fa fa-insert-template"></i><?php echo $objlang->get("text_hits");?></span> <?php echo $blog['hits'];?></span>
				<?php } ?>
				
				<?php if( $config->get('cat_show_comment_counter') ) { ?>
				<span class="comment_count"><span><i class="fa fa-comment"></i><?php echo $objlang->get("text_comment_count");?></span> <?php echo $blog['comment_count'];?></span>
				<?php } ?>
			</div>
		
		
			<?php if( $config->get('cat_show_description') ) {?>			
			<div class="description">
				<?php echo $blog['description'];?>
			</div>
			<?php } ?>
		
			<?php if( $config->get('cat_show_readmore') ) { ?>
			<div class="btn-more-link">
				<a href="<?php echo $blog['link'];?>" class="readmore btn button btn-theme-default"><?php echo $objlang->get('text_readmore');?></a>
			</div>
			<?php } ?>	
		
		</footer>	
	</div>

</article>