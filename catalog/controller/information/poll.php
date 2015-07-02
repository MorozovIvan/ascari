<?php
class ControllerInformationPoll extends Controller {
	public function index() {
    	$this->load->language('information/poll');
		$this->load->model('fido/poll');
		$this->document->breadcrumbs = array();
     	$this->document->breadcrumbs[] = array(
        	'href'      => HTTP_SERVER . 'index.php?route=common/home',
        	'text'      => $this->language->get('text_home'),
        	'separator' => FALSE
     	);
		$active_poll = $this->model_fido_poll->getActivePoll();
		if ($active_poll) {
			$poll_id = $active_poll['poll_id'];
		} else {
			$poll_id = 0;
		}
		if ($poll_id != 0) {
	  		$this->document->title = $this->language->get('heading_title');
     		$this->document->breadcrumbs[] = array(
        		'href'      => HTTP_SERVER . 'index.php?route=information/poll',
        		'text'      => $this->language->get('heading_title'),
        		'separator' => $this->language->get('text_separator')
     		);
     		$this->data['heading_title'] = $this->language->get('heading_title');
			$this->data['text_no_votes'] = $this->language->get('text_no_votes');
			$this->data['text_total_votes'] = $this->language->get('text_total_votes');
			$reactions = $this->model_fido_poll->getPollResults($poll_id);
			$total_votes = $this->model_fido_poll->getTotalResults($poll_id);
			if ($reactions) {
				$this->data['reactions'] = TRUE;
				$percent = array(0, 0, 0, 0, 0, 0, 0, 0);
				$totals  = array(0, 0, 0, 0, 0, 0, 0, 0);
				foreach($reactions as $reaction) {
					$totals[$reaction['answer'] - 1]++;
				}
				for($i = 0; $i < 8; $i++) {
					$percent[$i] = round(100 * ($totals[$i]/$total_votes));
				}
				$this->data['percent'] = $percent;
				$this->data['total_votes'] = $total_votes;
				$this->data['poll_data'] = $this->model_fido_poll->getPollData($poll_id);
				$this->data['text_poll_results'] = $this->language->get('text_poll_results');
				$this->data['text_percent'] = $this->language->get('text_percent');
				$this->data['text_answer'] = $this->language->get('text_answer');
			}
     		$this->data['button_continue'] = $this->language->get('button_continue');
			$this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/poll.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/poll.tpl';
			} else {
				$this->template = 'default/template/information/poll.tpl';
			}
			$this->children = array(
				'common/column_right',
				'common/footer',
				'common/column_left',
				'common/header'
			);
	  		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
    	} else {
	  		$this->document->title = $this->language->get('text_error');
     		$this->document->breadcrumbs[] = array(
        		'href'      => HTTP_SERVER . 'index.php?route=information/poll',
        		'text'      => $this->language->get('text_error'),
        		'separator' => $this->language->get('text_separator')
     		);
     		$this->data['heading_title'] = $this->language->get('text_error');
     		$this->data['text_error'] = $this->language->get('text_error');
     		$this->data['button_continue'] = $this->language->get('button_continue');
     		$this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
			$this->children = array(
				'common/column_right',
				'common/footer',
				'common/column_left',
				'common/header'
			);
	  		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	  	}
  	}
}
?>
