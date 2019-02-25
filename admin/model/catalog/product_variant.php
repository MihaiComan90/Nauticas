<?php
class ModelCatalogProductVariant extends Model {

    const VARIANT_IMAGE_DIRECTORY = 'product/variants/';

    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "product_variants`");
    }

    public function install() {
        $this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_variants` (
			  `variant_id` INT(11) NOT NULL AUTO_INCREMENT,
			  `product_id` INT(11) NOT NULL,
			  `attribute_id` INT(11) NOT NULL,
			  `price` FLOAT(12,4) NULL,
			  `image` VARCHAR(100) NULL,
			  `custom_url` VARCHAR(100) NULL,
			  `date_added` DATETIME NOT NULL,
			  `date_modified` DATETIME NOT NULL,
			  PRIMARY KEY (`variant_id`)
			) ENGINE=MyISAM DEFAULT COLLATE=utf8_general_ci;");
    }

    public function handleVariantImage($data)
    {
        // Make sure we have the correct directory
        $directory = rtrim(DIR_IMAGE . 'catalog/' . str_replace(array('../', '..\\', '..'), '', self::VARIANT_IMAGE_DIRECTORY), '/');

        // Check its a directory
        if (!is_dir($directory)) {
            $json['error'] = $this->language->get('error_directory');
        }

        if (!$json) {
            if (!empty($data['variant_image']['name']) && is_file($data['variant_image']['tmp_name'])) {
                // Sanitize the filename
                $filename = basename(html_entity_decode($data['variant_image']['name'], ENT_QUOTES, 'UTF-8'));

                // Validate the filename length
                if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 255)) {
                    $json['error'] = $this->language->get('error_filename');
                }

                // Allowed file extension types
                $allowed = array(
                    'jpg',
                    'jpeg',
                    'gif',
                    'png'
                );

                if (!in_array(utf8_strtolower(utf8_substr(strrchr($filename, '.'), 1)), $allowed)) {
                    $json['error'] = $this->language->get('error_filetype');
                }

                // Allowed file mime types
                $allowed = array(
                    'image/jpeg',
                    'image/pjpeg',
                    'image/png',
                    'image/x-png',
                    'image/gif'
                );

                if (!in_array($data['variant_image']['type'], $allowed)) {
                    $json['error'] = $this->language->get('error_filetype');
                }

                // Check to see if any PHP files are trying to be uploaded
                $content = file_get_contents($data['variant_image']['tmp_name']);

                if (preg_match('/\<\?php/i', $content)) {
                    $json['error'] = $this->language->get('error_filetype');
                }

                // Return any upload error
                if ($data['variant_image']['error'] != UPLOAD_ERR_OK) {
                    $json['error'] = $this->language->get('error_upload_' . $data['variant_image']['error']);
                }
            } else {
                $json['error'] = $this->language->get('error_upload');
            }
        }

        if (!$json) {
            $destination = $directory . '/' . $filename;
            move_uploaded_file($data['variant_image']['tmp_name'], $destination);
        }

        return $filename;
    }

	public function addProductVariant($product_id, $attribute_id, $data) {

        $this->load->language('common/filemanager');

        $json = array();

        // Check user has permission
        if (!$this->user->hasPermission('modify', 'common/filemanager')) {
            $json['error'] = $this->language->get('error_permission');
        }

        if(isset($data['variant_image'])){
            $filename = $this->handleVariantImage($data);
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "product_variants 
                            SET 
                                product_id = '" . (int)($product_id) . "', 
                                attribute_id = '" . (int)($attribute_id) . "', 
                                price = '" . (float)($data['price']) . "', 
                                image = '" . $this->db->escape($filename) . "',
                                custom_url = '" . $this->db->escape($data['custom_url']) . "', 
                                date_modified = NOW(),
                                date_added = NOW() 
                            ");

        $this->handleVariantUrlAlias($product_id,$this->db->getLastId(), $this->db->escape($data['custom_url']), 'insert');

        //$this->cache->set('product_variant_');
		return $product_id;
	}

	public function handleVariantUrlAlias($product_id, $variant_id, $url, $action = 'delete')
    {

        $this->db->query("DELETE FROM ". DB_PREFIX . "url_alias WHERE query LIKE 'product_id={$product_id}&variant={$variant_id}'");


        if($action == 'insert' && strlen($url)) {
            $this->db->query("INSERT INTO ". DB_PREFIX . "url_alias
                      SET 
                        query = 'product_id={$product_id}&variant={$variant_id}',
                        keyword = '{$url}'
            ");
        }
    }

	public function editProductVariant($product_id, $variantOptions) {

        if(isset($variantOptions['variant_image']) && strlen($variantOptions['variant_image']['tmp_name'])){
            $filename = $this->handleVariantImage($variantOptions);
        } elseif(isset($variantOptions['image'])) {
            $filename = $variantOptions['image'];
        }

        $this->db->query("UPDATE " . DB_PREFIX . "product_variants 
                            SET 
                                price = '" . (float)($variantOptions['price']) . "', 
                                image = '" . $this->db->escape($filename) . "',
                                custom_url = '" . $this->db->escape($variantOptions['custom_url']) . "', 
                                date_modified = NOW()
                            WHERE
                                variant_id = '".(int)$variantOptions['variant_id']."'
                            ");

        $this->handleVariantUrlAlias($product_id , $variantOptions['variant_id'], $this->db->escape($variantOptions['custom_url']) , 'insert');
	}

    public function deleteProductVariant($product_id, $attribute_id, $variant_id = null) {

        if(!is_null($variant_id)) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_variants WHERE variant_id ='{$variant_id}'");
            $this->handleVariantUrlAlias($product_id, $variant_id, '');
        } else {
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_variants WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '".$attribute_id."'");
        }

        $this->cache->delete('product');
    }

	public function getProductAttributeVariants($product_id, $attribute_id)
    {
        $product_variants = array();

        $product_variants_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_variants WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '".$attribute_id."'");

        if($product_variants_query) {
            foreach ($product_variants_query->rows as $product_variant) {
                if(isset($product_variant['image']) && strlen($product_variant['image']) && is_file(DIR_IMAGE . VARIANT_IMAGE_PATH . $product_variant['image'])) {
                    $product_variant['thumb_image'] =  $this->model_tool_image->resize(VARIANT_IMAGE_PATH . $product_variant['image'], 100, 100);
                }
                $product_variants[] = $product_variant;
            }
        }

        return $product_variants;
    }
}
