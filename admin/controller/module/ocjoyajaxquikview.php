<?php
class ControllerModuleOcjoyajaxquikview extends Controller {
	private $error = array(); 
	public function index() {   
	    $this->data += $this->load->language('module/ocjoyajaxquikview');  
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {			
			$this->model_setting_setting->editSetting('ocjoyajaxquikview', $this->request->post);	
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/ocjoyajaxquikview', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['error_warning'] = (isset($this->error['warning'])) ? $this->error['warning'] : '';

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
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
		    'href'      => $this->url->link('module/ocjoyajaxquikview', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('module/ocjoyajaxquikview', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			
	    $this->data['config_ocjoyajaxquikview_form'] = (isset($this->request->post['config_ocjoyajaxquikview_form'])) ? $this->request->post['config_ocjoyajaxquikview_form'] : $this->config->get('config_ocjoyajaxquikview_form');

		$this->template = 'module/ocjoyajaxquikview.tpl';

		$this->children = array('common/header','common/footer');		

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/ocjoyajaxquikview')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return (!$this->error) ? true : false;
	}
}
?>