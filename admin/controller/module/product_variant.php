<?php

class ControllerModuleProductVariant extends Controller {
    private $error = array();

    public function install() {
        $this->load->model('catalog/product_variant');
        $this->load->model('extension/event');
        $this->model_catalog_product_variant->install();
        $this->model_extension_event->addEvent('change_product_details', 'post.catalog.product.view', 'product/product_variants/changeProductDetails');
        $this->model_extension_event->addEvent('change_cart_details', 'post.cart.items.update', 'product/product_variants/changeCartItems');
    }

    public function uninstall() {
        $this->load->model('catalog/product_variant');
        $this->model_catalog_product_variant->uninstall();
        $this->load->model('extension/event');
        $this->model_extension_event->deleteEvent('change_product_details');
        $this->model_extension_event->deleteEvent('change_cart_details');
    }

    public function index() {
        $this->language->load('module/product_variant');

        $this->load->model('setting/setting');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('product_variant', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_button_grey'] = $this->language->get('text_button_grey');
        $data['text_button_blue'] = $this->language->get('text_button_blue');
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_module_add'] = $this->language->get('button_module_add');
        $data['button_remove'] = $this->language->get('button_remove');
        $data['enable_module_label'] = $this->language->get('enable_module_label');
        $data['option_label_disable'] = $this->language->get('option_label_disable');
        $data['option_label_enable'] = $this->language->get('option_label_enable');


        $data['variant_module_enabled'] = $this->config->get('product_variant_enable');
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/product_variant', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['action'] = $this->url->link('module/product_variant', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        $data['return_url'] = HTTPS_CATALOG . 'index.php?route=module/product_variant';

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/product_variant.tpl', $data));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/product_variant')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }
}