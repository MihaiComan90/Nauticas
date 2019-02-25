<?php
class ModelCatalogProductVariant extends Model {

    const VARIANT_IMAGE_DIRECTORY = 'product/variants/';

    public function loadProductVariant( $variant_id )
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_variants WHERE variant_id = '{$variant_id}'");

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
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_variants WHERE product_id = '{$product_id}'");

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
