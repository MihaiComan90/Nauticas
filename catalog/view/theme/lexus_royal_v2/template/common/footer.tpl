<?php 

  /*

  * @package Framework for Opencart 2.0

  * @version 2.0

  * @author http://www.pavothemes.com

  * @copyright Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.

  * @license   GNU General Public License version 2

  */

  require_once(DIR_SYSTEM . 'pavothemes/loader.php');

  $config = $this->registry->get('config'); 

  $helper = ThemeControlHelper::getInstance( $this->registry, $config->get('config_template') );

  $layoutID = 1 ;



?>

 <?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');   ?>

<!-- 

  $ospans: allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]

 -->



<?php if( !($helper->getConfig('enable_pagebuilder') && $helper->isHomepage())  ){ ?>



<?php

  $blockid = 'mass_bottom';

  $blockcls = '';

  $modules = $helper->getModulesByPosition( $blockid ); 

  $ospans = array();

  $tmcols = 'col-sm-12 col-xs-12';

  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );

?>



<?php } ?>

 

<footer id="footer">

 

  <?php

    $blockid = 'footer_top';

    $blockcls = '';

    $ospans = array(1=>12, 2=>12);

    $tmcols = 'col-xs-12';

    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );

  ?>



  <?php

    /**

   * Footer Center Position

   * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]

   */

    $blockid = 'footer_center';

    $blockcls = '';

    $ospans = array();

    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );

  ?>



  <?php

    /**

   * Footer Bottom

   * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]

   */

  $blockid = 'footer_bottom';

  $blockcls = '';

  $modules = $helper->getModulesByPosition( $blockid ); 

  $ospans = array(1=>4,2=>3,3=>3,4=>2);

  if( count($modules) &&  $helper->getConfig('enable_footer_bottom') ){

    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );



  } else { ?>

  <div class="footer-bottom pb-3">

    <div class="container">

      <div class="container-inner">

      <div class="row">

         <?php if ($informations) { ?>

          <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">

            <div class="box">

              <div class="box-heading"><span><?php echo $text_information; ?></span></div>

                <ul class="box-content list">
                  <li><a href="/index.php?route=information/gdpr_request">Sterge datele personale</a></li>
                  <li><a href="/index.php?route=account/gdpr">GDPR</a></li>
                  <li><a href="/index.php?route=information/gdpr_forget_me">Datele personale</a></li>
                  <?php foreach ($informations as $information) { ?>

                  <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>

                  <?php } ?>

                </ul>         

            </div>

          </div>

          <?php } ?>

          

        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">

          <div class="box">

            <div class="box-heading"><span><?php echo $text_account; ?></span></div>

            <ul class="box-content list">

              <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>

              <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>

              <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>

              <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>

              <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>

            </ul>

          </div>

        </div>



      <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">

        <?php

          echo $helper->renderModule('pavnewsletter');

        ?>

      </div>



        <?php if( $content=$helper->getLangConfig('widget_contact_us') ) {?>

        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">

          <div class="box">

            <div class="box-heading"><span><?php echo $objlang->get('text_contact_us'); ?></span></div>

            <?php echo $content; ?>

          </div>

        </div>

        <?php } ?>

    </div>

    </div>

     </div> </div> 

<?php  } ?> 



<div id="powered">

  <div class="container">

    <div class="d-flex justify-content-between pt-3 powered">

      <div class="copyright">

        <?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>

          <?php echo $helper->getConfig('copyright'); ?>

        <?php } else { ?>

          <?php echo $powered; ?>. 

        <?php } ?>

      </div>

      <?php if( $content=$helper->getLangConfig('widget_paypal') ) {?>

        <div class="paypal">

          <?php echo $content; ?>

        </div>

      <?php } ?> 

    </div>

  </div>

</div>





</footer>



<?php if( $helper->getConfig('enable_paneltool',0) ){  ?>

  <?php  echo $helper->renderAddon( 'panel' );?>

<?php } ?>

</div>

<?php  echo $helper->renderAddon( 'offcanvas' );?> 

</div>

<script>document.write('<script src="http://' + (location.host || 'nautica.local').split(':')[0] + ':35729/livereload.js"></' + 'script>')</script>
</body></html>