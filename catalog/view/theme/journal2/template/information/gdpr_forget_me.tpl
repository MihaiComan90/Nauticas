<?php echo $header; ?>
<div id="container" class="container j-container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_forget_me_instructions; ?></legend>

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

      <?php echo $content_bottom; ?>
    </div>

    <?php echo $column_right; ?>
  </div>
</div>
<?php echo $footer; ?>
