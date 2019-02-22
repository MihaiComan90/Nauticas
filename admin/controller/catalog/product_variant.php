<?php
class ControllerCatalogProductVariant extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/product_variant');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_variant');
	}
}