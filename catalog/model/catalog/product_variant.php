<?php
class ModelCatalogProductVariant extends Model {

    const VARIANT_IMAGE_DIRECTORY = 'product/variants/';

    public function loadProductVariant( $variant_id )
    {
        $query = $this->db->query("SELECT 
                                      pa.text as variant_name, 
                                      pv.* 
                                    FROM " . DB_PREFIX . "product_variants pv
                                    INNER JOIN " . DB_PREFIX . "product_attribute pa ON (pv.product_id = pa.product_id) AND (pv.attribute_id = pa.attribute_id)
                                    WHERE variant_id = '{$variant_id}' AND 
                                        pa.language_id = '" . (int)$this->config->get('config_language_id') . "'" );

        if ($query->num_rows) {
            if(strlen($query->row['image'])) {
                $this->load->model('tool/image');
                $imagePath = VARIANT_IMAGE_PATH . $query->row['image'];
                $query->row['image_thumb'] = $this->model_tool_image->resize($imagePath,$this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));
            }
            return $query->row;
        } else {
            return false;
        }
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

    public function getVariantCartKey($product_id, $variant_id)
    {
        return base64_encode(serialize(array('product_id' => $product_id, 'variant_id' => $variant_id)));
    }
}
