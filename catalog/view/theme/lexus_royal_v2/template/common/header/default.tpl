<?php

$objlang = $this->registry->get('language');

?>

<div id="header">

<header id="header-main">

<div class="container">
		<!-- Widget - Topbar Block -->
		<?php if( $content=$helper->getLangConfig('widget_topbar_data') ) {?>
			<div class="row">
				<div class="col-12">
					<?php echo $content; ?>		
				</div>
			</div>
		<?php } ?>

		<div class="row">
			<!-- Logo -->
			<div class="col-md-2">
				<?php if( $logoType=='logo-theme'){ ?>
					<div  id="logo-theme" class="logo-store">
						<a class="d-block" href="<?php echo $home; ?>">
							<span><?php echo $name; ?></span>
						</a>
					</div>
				<?php } elseif ($logo) { ?>
					<div id="logo" class="logo-store">
						<a class="d-block" href="<?php echo $home; ?>">
							<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
						</a>
					</div>
				<?php } ?>
			</div>

			<!-- Search -->
			<?php echo $search; ?>

			<!-- Currency / Language / My Account -->
			<div class="user-section col-md-3 d-flex align-self-center justify-content-between">
				<div class="mymenu btn-group d-none">
					<button type="button" class="btn btn-theme-normal dropdown-toggle" data-toggle="dropdown">
						<?php if($objlang->get('yes') =='Yes') {echo "Menu";} else {echo "Meniu";} ?>
						<span class="caret"></span>
					</button>

					<ul class="dropdown-menu">
						<li><a class="wishlist" href="<?php echo $wishlist; ?>" id="wishlist-total">
							<span class="fa fa-heart"></span>
							<span><?php echo $text_wishlist; ?></span></a>
						</li>
						<li><a class="account" href="<?php echo $account; ?>">
							<span class="fa fa-user"></span>
							<span><?php echo $text_account; ?></span></a>
						</li>
						<li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>">
							<span class="fa fa-shopping-cart"></span>
							<span><?php echo $text_shopping_cart; ?></span></a>
						</li>
						<li><a class="last checkout" href="<?php echo $checkout; ?>">
							<span class="fa fa-file"></span>
							<span><?php echo $text_checkout; ?></span></a>
						</li> 
					</ul>
				</div>

				<!-- Language -->
				<div class="language">
					<?php echo $language; ?>
				</div> 

				<!-- My Account -->
				<div class="login">
					<div class="btn-group dropdown">
					<?php if ($logged) { ?>
						<a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
					<?php } else { ?>
						<button class="btn btn-theme-normal"><i class="fa fa-user"></i>&nbsp;<?php echo $text_my_account; ?></button>
						<div class="dropdown-menu">
							<a class="btn btn-block btn-link" href="<?php echo $register; ?>"><?php echo $text_register; ?></a>
							<a class="btn btn-block btn-link" href="<?php echo $login; ?>"><?php echo $text_login; ?></a>  
						</div>
					<?php } ?>
					</div>
				</div>

				<!-- Mini Cart -->
				<?php echo $cart; ?>
  			</div>
		</div>
		


		<!--Sopport Mobile-->

		<div class="show-mobile pull-left hidden-lg hidden-md clearfix">

		    <div class="quick-access pull-left">

		    	<div class="quickaccess-toggle">    		

		    		<button data-toggle="offcanvas" class="button visible-xs visible-sm" type="button"><i class="fa fa-bars"></i></button>

		    	</div>           	

            </div>					

			<div class="quick-access pull-right">

				<div class="quickaccess-toggle">

					<i class="fa fa-user"></i>															

				</div>

				<div class="inner-toggle">

					<ul class="links pull-left">						

						<li><a href="<?php echo $wishlist; ?>"><i class="fa fa-heart"></i><?php echo $text_wishlist; ?></a></li>

						<li><a href="<?php echo $account; ?>"><i class="fa fa-user"></i><?php echo $text_account; ?></a></li>

						<li><a href="<?php echo $shopping_cart; ?>"><i class="fa fa-shopping-cart"></i><?php echo $text_shopping_cart; ?></a></li>

						<li><a class="last" href="<?php echo $checkout; ?>"><i class="fa fa-file"></i><?php echo $text_checkout; ?></a></li>

					</ul>	

				</div>

			</div>			

		</div>


		<div class="pull-right hidden-lg hidden-md hidden-xs clearfix">

			<?php if( $content=$helper->getLangConfig('widget_topbar_data') ) {?>

			<div class="column pull-left">

				 <?php echo $content; ?>

			</div>

	        <?php } ?>

	  	</div>


</div>

<!-- menu -->  		  
</header>
<nav id="topbar">

  <div class="container">

  	<div class="topbar">

  		<div class="pull-left menu inner">

			<div id="pav-mainnav">

				<div class="container-inner">

					<div class="row">

						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

					<?php

					/**

					 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu

					 */

					$modules = $helper->renderModule('pavmegamenu');



					if (count($modules) && !empty($modules)) { ?>



					    

					<?php echo $modules; ?>

					 



					<?php } elseif ($categories) { ?>



					    <div class="navbar navbar-inverse"> 

					        <nav id="mainmenutop" class="pav-megamenu" role="navigation"> 

					            <div class="navbar-header">

					                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">

					                    <span class="sr-only">Toggle navigation</span>

					                    <span class="fa fa-bars"></span>

					                </button>

					            </div>



					            <div class="collapse navbar-collapse navbar-ex1-collapse">

					                <ul class="nav navbar-nav">

					                    

					                    <?php foreach ($categories as $category) { ?>



					                        <?php if ($category['children']) { ?>			

					                            <li class="parent dropdown deeper ">

					                                <a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>

					                                    <b class="fa fa-angle-down"></b>

					                                    <span class="triangles"></span>

					                                </a>

					                            <?php } else { ?>

					                            <li>

					                                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>

					                            <?php } ?>

					                            <?php if ($category['children']) { ?>

					                                <ul class="dropdown-menu">

					                                    <?php for ($i = 0; $i < count($category['children']);) { ?>

					                                        <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>

					                                        <?php for (; $i < $j; $i++) { ?>

					                                            <?php if (isset($category['children'][$i])) { ?>

					                                                <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>

					                                            <?php } ?>

					                                        <?php } ?>

					                                    <?php } ?>

					                                </ul>

					                            <?php } ?>

					                        </li>

					                    <?php } ?>

					                </ul>

					            </div>	

					        </nav>

					    </div>   

					<?php } ?>

				</div>

			</div>

			</div>

			</div>



		</div>


		
  	</div>

  </div>

</nav>

</div>











