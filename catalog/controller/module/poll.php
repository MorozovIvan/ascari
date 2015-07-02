<?php
class ControllerModulePoll extends Controller {
	protected function index() {
		
		$this->language->load('module/poll');

      	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('module/poll');

		$poll_info = $this->model_module_poll->getPollName();
		$this->data['poll_name'] = $poll_info['name'];
		$this->data['poll_responses'] = $this->model_module_poll->getPollResponses($poll_info['id']);

		$this->data['poll_color'] = $this->config->get('poll_color');
		$this->data['poll_ajax_url'] = $this->url->link('module/poll/answerPoll');


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/poll.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/poll.tpl';
		} else {
			$this->template = 'default/template/module/poll.tpl';
		}

		$this->render();
	}
	
	public function answerPoll() 
	{
		$this->load->model('module/poll');
		$voted = false;
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (isset($this->request->post['poll_response_add']) && $this->request->post['poll_response_add']) {
				if (isset($this->session->data['poll_voted'])) {
					$voted = true;  
				} else {
					$this->model_module_poll->answerPoll($this->request->post['poll_response_add']);
					$this->session->data['poll_voted'] = 1;
				}
			}
		}
		$this->response->setOutput($this->model_module_poll->pollResults($voted));
	}
}
?>