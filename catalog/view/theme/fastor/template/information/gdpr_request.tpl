<?php echo $header;
$theme_options = $registry->get('theme_options');
$config = $registry->get('config');
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

      <h1><?php echo $heading_title; ?></h1>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_instructions; ?></legend>

          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php if(VERSION < '2.1.0.0') { ?>
            <?php if ($site_key) { ?>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                  <?php if ($error_captcha) { ?>
                    <div class="text-danger"><?php echo $error_captcha; ?></div>
                  <?php } ?>
                </div>
              </div>
            <?php } ?>
          <?php } ?>

          <?php if(VERSION > '2.0.3.1') { ?>
            <?php echo $captcha; ?>
          <?php } ?>

        </fieldset>
        <div class="buttons">
          <div class="pull-right">
            <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
          </div>
        </div>
      </form>

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>
