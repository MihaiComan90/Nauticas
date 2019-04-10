<?php
class ControllerProductProductVariants extends Controller {

	public function changeProductDetails($data)
    {
        $sufferedChanges = false;

        if(isset($data['product_variant'])){
            $options = $data['product_variant'];
            $newVariantPrice = 0;
            /* Calculate percentage of current discount to base the variant price on*/
            if ((float)$data['special']) {
                $percentageValue = (float)$data['special'] / (float)$data['price'];
            }

            $discounts = $this->model_catalog_product->getProductDiscounts($data['product_id']);

            $data['discounts'] = array();

            /* Calcuate new discounts based on quantity */
            foreach ($discounts as $discount) {
                $quantityPercentageValue = (float)$discount['price'] / (float)$data['price'];
                $newVariantQuantityPrice = (float)$options['price'] * $quantityPercentageValue;
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price'    => $this->currency->format($this->tax->calculate($newVariantQuantityPrice, $data['tax_class_id'], $this->config->get('config_tax')))
                );
            }
            /* @todo do we make a gallery separate from product images or replace the product with the variant image
             * if ($options['image']) {
                $this->load->model('tool/image');
                $imagePath = VARIANT_IMAGE_PATH . $options['image'];
                $data['popup'] = $this->model_tool_image->resize($imagePath, $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
                $data['thumb'] = $this->model_tool_image->resize($imagePath, $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
            }*/

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($options['price'], $data['tax_class_id'], $this->config->get('config_tax')));
            }

            if (isset($percentageValue)) {
                $newVariantPrice = $percentageValue * (float)$options['price'];
                $data['special'] = $this->currency->format($this->tax->calculate($newVariantPrice, $data['tax_class_id'], $this->config->get('config_tax')));
            }

            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float)$newVariantPrice ? $newVariantPrice : $options['price']);
            } else {
                $data['tax'] = false;
            }

            $sufferedChanges = true;
        }

        if($sufferedChanges) {
            unset($this->session->data['changed_details']);
            $this->session->data['changed_details'] = $data;
        }
    }

    public function changeCartItems($data)
    {
        if(!count($data)) {
            unset($this->session->data['cart_variant_ids']);
            return;
        }

        $variantInfo = array();

        foreach($this->session->data['cart_variant_ids'] as $info => $quantity) {
            $unserializedInfo = unserialize(base64_decode($info));
            $variantInfo[$unserializedInfo['product_id']] = array(
                'variant_id' => $unserializedInfo['variant_id'],
                'quantity'   => $quantity,
                'key'        => $info
            );
        }

        foreach($data as $key => $product) {
            if(isset($variantInfo[$product['product_id']]) && $key == $variantInfo[$product['product_id']]['key']) {
                $data[$key]['product_variant'] = $variantInfo[$product['product_id']];
            }
        }

        $sufferedChanges = false;
        if(count($data)) {
            $this->load->model('catalog/product_variant');

            foreach($data as $key => $product) {
                if(isset($product['product_variant']) && $product['product_variant']) {
                    $variant = $this->model_catalog_product_variant->loadProductVariant($product['product_variant']['variant_id']);
                    if($variant) {
                        // Display prices
                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                            $data[$key]['price'] = (float)$variant['price'];
                        }
                        // Display prices
                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                            $data[$key]['total'] = (float)$variant['price'] * $data[$key]['quantity'];
                        }

                        $data[$key]['name'] .= ' - '. $variant['name'];
                        $sufferedChanges = true;
                    }
                }
            }
        }

        if($sufferedChanges) {
            $this->reflection->setReflectedProperty($this->cart, array('data' => $data));
        }
    }
}
