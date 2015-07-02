<?php
class ControllerModuleNivoSlider extends Controller {
	private $error = array();

	public function index() {

		$description = $this->db->query("DESC " . DB_PREFIX . "banner_image_description description");
		if (!$description->num_rows) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "banner_image_description` ADD `description` varchar(255) NOT NULL default 'banner description'");
		}

		$link = $this->db->query("DESC " . DB_PREFIX . "banner_image_description link");
		if (!$link->num_rows) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "banner_image_description` ADD `link` varchar(255) NOT NULL default ''");
		}

		$sort_order = $this->db->query("DESC " . DB_PREFIX . "banner_image sort_order");
		if (!$sort_order->num_rows) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "banner_image` ADD `sort_order` int(11) NOT NULL");
		}

		$this->document->addStyle('view/stylesheet/resp_nivo_slider/resp_nivo_slider.css');
		$this->language->load('module/nivoslider');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting('nivoslider', $this->request->post);

			if ($this->request->post['apply']) {
				$this->redirect($this->url->link('module/nivoslider', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->session->data['success'] = $this->language->get('text_success');
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['default_store'] = $this->config->get('config_name');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');

		$this->data['entry_module_name'] = $this->language->get('entry_module_name');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_featured_cat'] = $this->language->get('entry_featured_cat');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['text_elegant_style'] = $this->language->get('text_elegant_style');
		$this->data['text_bar_style'] = $this->language->get('text_bar_style');
		$this->data['text_light_style'] = $this->language->get('text_light_style');
		$this->data['text_dark_style'] = $this->language->get('text_dark_style');
		$this->data['text_default_style'] = $this->language->get('text_default_style');

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension');
		$this->data['entry_style'] = $this->language->get('entry_style');
		$this->data['entry_autoplay'] = $this->language->get('entry_autoplay');
		$this->data['entry_effect'] = $this->language->get('entry_effect');
		$this->data['entry_slices'] = $this->language->get('entry_slices');
		$this->data['entry_boxes'] = $this->language->get('entry_boxes');
		$this->data['entry_speed'] = $this->language->get('entry_speed');
		$this->data['entry_start'] = $this->language->get('entry_start');
		$this->data['entry_pause'] = $this->language->get('entry_pause');
		$this->data['entry_random'] = $this->language->get('entry_random');
		$this->data['entry_directionnav'] = $this->language->get('entry_directionnav');
		$this->data['entry_controlnav'] = $this->language->get('entry_controlnav');
		$this->data['entry_caption'] = $this->language->get('entry_caption');
		$this->data['entry_thumbnails'] = $this->language->get('entry_thumbnails');
		$this->data['entry_thumbwidth'] = $this->language->get('entry_thumbwidth');

		$this->data['entry_beforechange'] = $this->language->get('entry_beforechange');
		$this->data['entry_afterchange'] = $this->language->get('entry_afterchange');
		$this->data['entry_slideshowend'] = $this->language->get('entry_slideshowend');
		$this->data['entry_lastslide'] = $this->language->get('entry_lastslide');
		$this->data['entry_afterload'] = $this->language->get('entry_afterload');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_apply'] = $this->language->get('button_apply');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['tab_setting'] = $this->language->get('tab_setting');
		$this->data['tab_config'] = $this->language->get('tab_config');
		$this->data['tab_triggers'] = $this->language->get('tab_triggers');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
			);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
			);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/nivoslider', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
			);

		$this->data['action'] = $this->url->link('module/nivoslider', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		if (isset($this->request->post['nivoslider_module'])) {
			$this->data['modules'] = $this->request->post['nivoslider_module'];
		} elseif ($this->config->get('nivoslider_module')) { 
			$this->data['modules'] = $this->config->get('nivoslider_module');
		}

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('catalog/nivoslider');
		$this->data['categories'] = $this->model_catalog_nivoslider->getNivoSliderCategories(0);

		$this->load->model('design/banner');
		$this->data['banners'] = $this->model_design_banner->getBanners();

		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();

		$this->template = 'module/nivoslider.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
			);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/nivoslider')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>