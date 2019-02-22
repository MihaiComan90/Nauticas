<?php

class ControllerModuleProductVariant extends Controller {
    private $error = array();

    public function install() {
        $this->load->model('catalog/product_variant');

        $this->model_catalog_product_variant->install();
    }

    public function uninstall() {
        $this->load->model('catalog/product_variant');

        $this->model_catalog_product_variant->uninstall();
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

        $data['entry_client_id'] = $this->language->get('entry_client_id');
        $data['entry_secret'] = $this->language->get('entry_secret');
        $data['entry_sandbox'] = $this->language->get('entry_sandbox');
        $data['entry_debug'] = $this->language->get('entry_debug');
        $data['entry_customer_group'] = $this->language->get('entry_customer_group');
        $data['entry_button'] = $this->language->get('entry_button');
        $data['entry_seamless'] = $this->language->get('entry_seamless');
        $data['entry_locale'] = $this->language->get('entry_locale');
        $data['entry_return_url'] = $this->language->get('entry_return_url');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['help_sandbox'] = $this->language->get('help_sandbox');
        $data['help_customer_group'] = $this->language->get('help_customer_group');
        $data['help_seamless'] = $this->language->get('help_seamless');
        $data['help_debug_logging'] = $this->language->get('help_debug_logging');
        $data['help_locale'] = $this->language->get('help_locale');
        $data['help_return_url'] = $this->language->get('help_return_url');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_module_add'] = $this->language->get('button_module_add');
        $data['button_remove'] = $this->language->get('button_remove');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['client_id'])) {
            $data['error_client_id'] = $this->error['client_id'];
        } else {
            $data['error_client_id'] = '';
        }

        if (isset($this->error['secret'])) {
            $data['error_secret'] = $this->error['secret'];
        } else {
            $data['error_secret'] = '';
        }

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