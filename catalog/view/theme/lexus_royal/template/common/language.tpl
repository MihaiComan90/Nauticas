<?php if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button class="btn btn-theme-normal dropdown-toggle" data-toggle="dropdown">
    <?php foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
    <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
    <?php } ?>
    <?php } ?>
    <span class="text-label"><?php echo $text_language; ?></span> <span class="caret"></span></button>
    <h4 class="hidden-md hidden-lg text-label">Your Language:</h4>
    <ul class="dropdown-menu">
      <?php foreach ($languages as $language) { ?>
      <li><a href="<?php echo $language['code']; ?>"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /><span class="hidden-sm hidden-xs"><?php echo $language['name']; ?></span></a></li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
