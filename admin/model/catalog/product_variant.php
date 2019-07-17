<?php
class ModelCatalogProductVariant extends Model {

    const VARIANT_IMAGE_DIRECTORY = 'product/variants/';

    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "product_variants`;");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product` DROP COLUMN `variant_id`;");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product` DROP COLUMN `variant_name`;");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "order_product` DROP COLUMN `variant_price`;");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "return` DROP COLUMN `variant_id`;");
    }

    public function install() {
        $this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_variants` (
			  `variant_id` INT(11) NOT NULL AUTO_INCREMENT,
			  `product_id` INT(11) NOT NULL,
			  `attribute_id` INT(11) NOT NULL,
			  `name` VARCHAR(100) NULL,
			  `price` FLOAT(12,4) NULL,
			  `image` VARCHAR(100) NULL,
			  `custom_url` VARCHAR(100) NULL,
			  `date_added` DATETIME NOT NULL,
			  `date_modified` DATETIME NOT NULL,
			  PRIMARY KEY (`variant_id`)
			) ENGINE=MyISAM DEFAULT COLLATE=utf8_general_ci;");

        $this->db->query("
            ALTER TABLE `".DB_PREFIX."order_product` ADD `variant_id` INT(10) NULL;
            ALTER TABLE `".DB_PREFIX."order_product` ADD `variant_name` VARCHAR(100) NULL;
            ALTER TABLE `".DB_PREFIX."order_product` ADD `variant_price` FLOAT(15,4) NULL;
        ");

        $this->db->query("
            ALTER TABLE `".DB_PREFIX."return` ADD `variant_id` INT(10) NULL AFTER `product_id`;
        ");
    }

    public function handleVariantImage($data)
    {
        $this->load->language('common/filemanager');

        $json = array();

        // Check user has permission
        if (!$this->user->hasPermission('modify', 'common/filemanager')) {
            $json['error'] = $this->language->get('error_permission');
        }
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

            return $filename;
        }

        return $json;
    }

	public function addProductVariant($product_id, $attribute_id, $data) {

        if(isset($data['variant_image'])){
            $result = $this->handleVariantImage($data);
            $filename = (is_array($result) && $result['error']? null : $result);
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "product_variants 
                            SET 
                                product_id = '" . (int)($product_id) . "', 
                                attribute_id = '" . (int)($attribute_id) . "',
                                `name` = '".$this->db->escape($data['name'])."', 
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
            $result  = $this->handleVariantImage($variantOptions);
            $filename = (is_array($result) && $result['error']? null : $result);
        } elseif(isset($variantOptions['image'])) {
            $filename = $variantOptions['image'];
        }

        $this->db->query("UPDATE " . DB_PREFIX . "product_variants 
                            SET 
                                price = '" . (float)($variantOptions['price']) . "', 
                                `name` = '".$this->db->escape($variantOptions['name'])."',
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

    public function getProductVariants($product_id)
    {
        $selectQuery = "SELECT 
              pa.text as variant_name,
              ad.name as attribute_name,
              pv.* 
            FROM " . DB_PREFIX . "product_variants pv
            INNER JOIN
                " . DB_PREFIX . "product_attribute pa ON (pv.product_id = pa.product_id) AND (pv.attribute_id = pa.attribute_id)
            INNER JOIN
                " . DB_PREFIX . "attribute_description ad ON (ad.attribute_id = pv.attribute_id) AND (ad.language_id = pa.language_id)
            WHERE 
                pv.product_id = '" . (int)$product_id . "'
            AND 
                pa.language_id = '" . (int)$this->config->get('config_language_id') . "'";


        $query = $this->db->query($selectQuery);

        $this->load->model('tool/image');

        if ($query->num_rows) {
            $data = array();
            foreach($query->rows as $k=>$row){
                $data[$k] = $row;
                if(strlen($row['image'])) {
                    $imagePath = VARIANT_IMAGE_PATH . $row['image'];
                    $data[$k]['image_thumb'] = $this->model_tool_image->resize($imagePath,$this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));
                }
            }

            return $data;
        } else {
            return false;
        }
    }
}
