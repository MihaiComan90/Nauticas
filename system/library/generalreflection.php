<?php

class GeneralReflection {

    public function __construct($registry) {
        $this->session = $registry->get('session');
        $this->cart    = $registry->get('cart');
    }

    public function setReflectedProperty( $class , $args) {
        $refObject = new ReflectionObject( $class );
        foreach($args as $type => $data) {
            $refProperty = $refObject->getProperty( $type );
            if($refProperty->isPrivate()) {
                $refProperty->setAccessible( true );
            }
            $refProperty->setValue( $class , $data);
        }
    }

    public function invokeMethod( $classAction , $args = array())
    {
        if(stripos($classAction, '-') === false) {
            return;
        }

        list($className, $methodName) = explode('-', $classAction);
        $selfMethodName = $className . ucfirst($methodName);

        if(method_exists($this, $selfMethodName) && (isset($this->{$className}) && method_exists($this->{$className}, $methodName))) {
            $this->{$selfMethodName}($args);
        }
    }

    protected function cartAdd($args = array())
    {
        if (!isset($args['variant_id'])) {
            $this->cart->add($args['product_id'], $args['quantity'], $args['option'], $args['recurring_id']);
            return;
        }

        $product['product_id'] = (int)$args['product_id'];
        $product['variant_id'] = (int)$args['variant_id'];

        if ($args['option']) {
            $product['option'] = $args['option'];
        }

        if ($args['recurring_id']) {
            $product['recurring_id'] = (int)$args['recurring_id'];
        }

        $key = base64_encode(serialize($product));

        if ((int)$args['quantity'] && ((int)$args['quantity'] > 0)) {
            if (!isset($this->session->data['cart'][$key])) {
                $this->session->data['cart'][$key] = (int)$args['quantity'];
            } else {
                $this->session->data['cart'][$key] += (int)$args['quantity'];
            }
        }
    }
}