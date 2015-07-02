<?php
class ControllerModulePoll extends Controller {
	private $error = array(); 

	public function install() {
		$this->load->model('module/poll');
		$this->model_module_poll->createModuleTables();	
	}
	
	public function index() {
		
		$this->load->language('module/poll');
		$this->load->model('setting/setting');
		
		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('poll', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->getList();
	}
	
	public function insert() {
		
		$this->load->language('module/poll');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->newPollValidate()) {
			
			$this->load->model('module/poll');
			
			$poll_data = array(
				'name' => $this->request->post['poll_name'],
				'active' => 1
			);
			$poll_data['responses'] = array();
			foreach ($this->request->post['poll_response'] as $response) {
				$poll_data['responses'][] = $response;
			}
			$this->model_module_poll->addPoll($poll_data);
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->getForm();
	}
	
	public function update() {
		
		$this->load->language('module/poll');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			
			if (isset($this->request->get['poll_id'])) {
				$this->load->model('module/poll');
				$this->model_module_poll->editPoll($this->request->get['poll_id'], $this->request->post);
				$this->session->data['success'] = $this->language->get('text_success');
			}
						
			$this->redirect($this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->getForm();
		
	}
	
	public function delete() {
		
		$this->load->language('module/poll');
		$this->load->model('module/poll');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		
		if (isset($this->request->post['selected']) && $this->validate()) {
			foreach ($this->request->post['selected'] as $poll_id) {
				$this->model_module_poll->deletePoll($poll_id);
	  		}

			$this->session->data['success'] = $this->language->get('text_success');
		
						
			$this->redirect($this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->getList();
		
	}
	
	
	private function getList() {
		
		$this->load->model('module/poll');
		
		$text_strings = array(
			'heading_title',
			'text_enabled',
			'text_disabled',
			'text_status',
			'text_poll',
			'text_action',
			'text_left',
			'text_column_left',
			'text_column_right',
			'text_no_results',
			'entry_position',
			'entry_status',
			'entry_sort_order',
			'entry_color',
			'button_save',
			'button_insert',
			'button_delete',
			'button_cancel',
			'button_add_module',
			'button_remove',
			'entry_layout'
		);
		
		foreach ($text_strings as $text) {
			$this->data[$text] = $this->language->get($text);
		}


 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}


		//SET UP BREADCRUMB TRAIL. YOU WILL NOT NEED TO MODIFY THIS UNLESS YOU CHANGE YOUR MODULE NAME.
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_module'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
   		$this->data['insert'] = $this->url->link('module/poll/insert', 'token=' . $this->session->data['token'], 'SSL');
   		
		$this->data['action'] = $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['delete'] = $this->url->link('module/poll/delete', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['poll_module'])) {
			$this->data['modules'] = $this->request->post['poll_module'];
		} elseif ($this->config->get('poll_module')) { 
			$this->data['modules'] = $this->config->get('poll_module');
		}		

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		
		// Config Items
		$config_data = array(
			'poll_color'
		);
		
		foreach ($config_data as $conf) {
			if (isset($this->request->post[$conf])) {
				$this->data[$conf] = $this->request->post[$conf];
			} else {
				$this->data[$conf] = $this->config->get($conf);
			}
		}
		
		$this->data['polls'] = array();
		$polls = $this->model_module_poll->getPolls();
		
		foreach ($polls as $poll) {
			$poll['action'] = array(
				'text' => $this->language->get('text_edit'),
				'href' => HTTPS_SERVER . 'index.php?route=module/poll/update&token=' . $this->session->data['token'] . '&poll_id=' . $poll['id']
			);
			$this->data['polls'][] = $poll;
		}
		
		$this->template = 'module/poll_list.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	private function getForm() {
		
		$this->load->model('module/poll');
		
		if (isset($this->request->get['poll_id'])) {
			
			$poll = $this->model_module_poll->getPoll($this->request->get['poll_id']);
			$this->data['poll_status'] = $poll['active'];
			$this->data['poll_name'] = $poll['name'];
			$this->data['poll_responses'] = $this->model_module_poll->getResponses($this->request->get['poll_id']);
		} else {
			$this->data['poll_status'] = 0;
			$this->data['poll_name'] = '';
			$this->data['poll_responses'] = array();
		}
		
		$text_strings = array(
			'heading_title',
			'text_active',
			'text_inactive',
			'text_status',
			'text_poll',
			'text_column_left',
			'text_column_right',
			'text_action',
			'text_left',
			'text_no_results',
			'entry_position',
			'entry_status',
			'entry_sort_order',
			'entry_poll_responses',
			'entry_poll_name',
			'entry_active',
			'button_save',
			'button_cancel',
		);
		
		foreach ($text_strings as $text) {
			$this->data[$text] = $this->language->get($text);
		}
			
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}


		//SET UP BREADCRUMB TRAIL. YOU WILL NOT NEED TO MODIFY THIS UNLESS YOU CHANGE YOUR MODULE NAME.
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_module'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		if (isset($this->request->get['poll_id'])) {
			$this->data['action'] = HTTPS_SERVER . 'index.php?route=module/poll/update&token=' . $this->session->data['token'] . '&poll_id=' . $this->request->get['poll_id'];
		} else {
			$this->data['action'] = $this->url->link('module/poll/insert', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL');

		
		
		$this->template = 'module/poll_form.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/poll')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
	
	private function newPollValidate() {
		if (!$this->user->hasPermission('modify', 'module/poll')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (isset($this->request->post['poll_question']) && count($this->request->post['poll_question']) < 2) {
			$this->error['warning'] = $this->language->get('error_two_questions');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>