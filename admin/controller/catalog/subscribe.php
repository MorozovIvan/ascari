<?php
class ControllerCatalogSubscribe extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/subscribe');

		$this->document->setTitle($this->language->get('heading_title_mail'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateEmailForm()) {
			$this->model_setting_setting->editSetting('subscribe_descriptions', $this->request->post);

			$this->redirect($this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title_mail');

		$this->data['entry_text_mail'] = $this->language->get('entry_text_mail');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['error_subscribe_description'])) {
			$this->data['error_subscribe_description'] = $this->error['error_subscribe_description'];
		} else {
			$this->data['error_subscribe_description'] = array();
		}

		$this->data['token'] = $this->session->data['token'];

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/subscribe', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		if (isset($this->request->post['subscribe_descriptions'])) {
			$this->data['subscribe_descriptions'] = $this->request->post['subscribe_descriptions'];
		} elseif ($this->config->get('subscribe_descriptions')) {
			$this->data['subscribe_descriptions'] = $this->config->get('subscribe_descriptions');
		}

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['action'] = $this->url->link('catalog/subscribe', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('catalog/subscribe', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'catalog/subscribe_mail.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validateEmailForm() {
		if (!$this->user->hasPermission('modify', 'catalog/subscribe')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$descriptions = $this->request->post['subscribe_descriptions'];

		foreach ($descriptions as $language_id => $description) {
			if ((utf8_strlen($description) < 0) || (utf8_strlen($description) > 30000)) {
				$this->error['error_subscribe_description'][$language_id] = $this->language->get('error_subscribe_description');
			}
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}

?>