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
			<div class="col-4 col-md-2">
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

			<!-- Currency / Language / My Account -->
			<div class="col-5 col-md-4 col-lg-4 order-1 order-md-2 offset-3 offset-md-0 user-section d-flex align-self-center justify-content-between">
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
						<button class="btn btn-theme-normal"><i class="fa fa-user"></i><span class="d-none d-lg-inline">&nbsp;<?php echo $text_my_account; ?></span></button>
						<div class="dropdown-menu">
							<a class="btn btn-block btn-link" href="<?php echo $register; ?>"><?php echo $text_register; ?></a>
							<a class="btn btn-block btn-link" href="<?php echo $login; ?>"><?php echo $text_login; ?></a>  
						</div>
					<?php } ?>
					</div>
				</div>

				<!-- Mini Cart -->
				<div id="minicart-container">
					<?php echo $cart; ?>
				</div>
  			</div>

			<!-- Search -->
			<?php echo $search; ?>
		</div>
</div>
</header>

<!-- Navigation -->  		  
<nav id="topbar">
  <div class="container">
	<a href="#mobile_menu" class="hamburger d-lg-none"><i class="fa fa-bars"></i></a>
  	<div class="topbar">
  		<div class="menu inner">
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











