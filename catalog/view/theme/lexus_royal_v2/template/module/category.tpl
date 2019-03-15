<div class="box category highlights">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>

	<div class="box-content">

		<ul class="box-category list">

			<?php 

				$k=0;
				$i=0;

				foreach ($categories as $category) {				

				$class = "";

					if(isset($category["children"]) && !empty($category["children"])){

					$class = "haschild";

				}

				$name = str_replace("(", '<span class="badge pull-right">',  $category['name'] );

				$category['name'] = str_replace(")", '</span>', $name); 

				$cls="cat".$i;
				$i++;

			?>

				


			<li class="<?php echo $cls . ' ' .$class; ?>">

				<?php if ($category['category_id'] == $category_id) { ?>

				<a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>

				<?php } else { ?>

				<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>

				<?php } ?>

				

				<?php if ($category['children']) { $k++; ?>				

				<a class="subcart fa fa-angle-double-down" data-toggle="collapse" data-parent="#accordion" href="#collapseOne<?php echo $k ;?>"><i class="fa fa-angle-double-down"></i></a>				
				<ul id="collapseOne<?php echo $k ;?>" class="panel-collapse collapse">
					<?php foreach ($category['children'] as $child) { ?>
						<?php
							$child['name'] = str_replace("(", '<span class="badge pull-right">',  $child['name'] );
							$child['name'] = str_replace(")", '</span>', $child['name']);  
							
						?>
					<li>
						<?php if ($child['category_id'] == $child_id) { ?>
						<a href="<?php echo $child['href']; ?>" class="active"> <?php echo $child['name']; ?></a>
						<?php } else { ?>
						<a href="<?php echo $child['href']; ?>"><?php echo $child['name'];?></a>
						<?php } ?>
					</li>
					<?php } ?>
				</ul>

				<?php } ?>




			</li>

			<?php } ?>

		</ul>

	</div>

</div>

