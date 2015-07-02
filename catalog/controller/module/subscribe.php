<?php
class ControllerModuleSubscribe extends Controller {
	private $error = array();

	public function index($setting = array()) {
		if (isset($this->request->post['module'])) {
			$module = $this->request->post['module'];
		} else {
			$module = $setting['subscribe_id'];

			$this->document->addScript('catalog/view/javascript/subscribe.js');
		}

		$this->data['module'] = $module;

		$this->language->load('module/subscribe');

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['button_subscribe'] = $this->language->get('button_subscribe');
		$this->data['text_enter_email'] = $this->language->get('text_enter_email');

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/subscribe.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/subscribe.tpl';
		} else {
			$this->template = 'default/template/module/subscribe.tpl';
		}

		$this->response->setOutput($this->render());
	}

	public function addSubscribe() {
		$json = array();

		$this->language->load('module/subscribe');
		$this->load->model('account/customer');
		$this->load->model('catalog/subscribe');

		$email_subscriber = $this->request->post['email'];

		if ((utf8_strlen($email_subscriber) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email_subscriber)) {
			$json['error'] = $this->language->get('error_email');
		} else {
			$customers_email = $this->model_catalog_subscribe->checkCustomers();

			foreach ($customers_email as $customer) {
				if ($customer['email'] == $email_subscriber) {
					$json['error'] = $this->language->get('error_customer');
				}
			}
		}

		if (!$json && isset($this->request->post['module'])) {
			$subscribes = $this->config->get('subscribe_module');

			$module = $this->request->post['module'];
			$email_alert = $subscribes[$module]['email_alert'];
			$subscribe_confirm = $subscribes[$module]['subscribe_confirm'];

			if ($subscribe_confirm) {
				$json['success'] = $this->language->get('text_subscribe_confirm');
			} else {
				$json['success'] = $this->language->get('text_success');
			}

			$customer_group_id = $subscribes[$module]['customer_group_id'];

			$password = uniqid(rand());

			$data = array(
				'firstname' => $this->language->get('text_subscriber') . '_' . $email_subscriber,
				'email' => $email_subscriber,
				'customer_group_id' => $customer_group_id,
				'password' => $password,
				'approved' => $subscribe_confirm ? 0 : 1
			);

			$this->model_catalog_subscribe->addCustomer($data);

			if ($subscribe_confirm) {
				$message = $this->language->get('text_subscribe_active');
				$message .= html_entity_decode($this->url->link('module/subscribe/confirmSubscribe&key=' . $this->keyCoding($email_subscriber), '', 'SSL') . "\n\n");
				$password_message = "\n\n";
			} else {
				$message = sprintf($this->language->get('text_hello_subscriber'), $this->config->get('config_name')) . "\n\n";
				$password_message = $this->language->get('text_password') . ' ' . $password . "\n\n";
			}

			$subscribe_descriptions = $this->config->get('subscribe_descriptions');
			$text_mail = $subscribe_descriptions[(int) $this->config->get('config_language_id')];
			$message .= $this->language->get('text_approval');
			$message .= $this->url->link('account/login', '', 'SSL') . "\n";
			$message .= $this->language->get('text_login') . ' ' . $email_subscriber . "\n";
			$message .= $password_message;
			$message .= strip_tags(html_entity_decode($text_mail, ENT_QUOTES, 'UTF-8'));

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');
			$mail->setTo($email_subscriber);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(sprintf($this->language->get('text_hello_subscriber'), $this->config->get('config_name')));
			$mail->setText($message);
			$mail->send();

			if ($email_alert) {
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');
				$mail->setTo($this->config->get('config_email'));
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject(sprintf($this->language->get('text_email_subject_shop'), $this->config->get('config_name', $email_subscriber)));
				$mail->setText(sprintf($this->language->get('text_email_text'), $email_subscriber));
				$mail->send();
			}
		}

		$this->response->setOutput(json_encode($json));
	}

	public function confirmSubscribe() {
		$this->load->model('catalog/subscribe');

		$this->language->load('module/subscribe');

		$this->document->setTitle($this->language->get('heading_title_confirm'));
		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->data['heading_title'] = $this->language->get('heading_title_confirm');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'href' => $this->url->link('module/subscribe/confirmSubscribe', '', 'SSL'),
			'text' => $this->language->get('heading_title_confirm'),
			'separator' => $this->language->get('text_separator')
		);

		if (isset($this->request->get['key'])) {
			$key = $this->request->get['key'];
		} else if (isset($this->request->post['key'])) {
			$key = $this->request->post['key'];
		} else {
			$key = 0;
		}

		if ($this->keyValidate($key)) {
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePassword()) {
				$this->load->model('account/customer');

				$data = $this->getDataSubscriber($key);

				$this->model_catalog_subscribe->approvedCustomer($data['customer_id']);

				$this->model_account_customer->editPassword($data['email'], $this->request->post['password']);

				$this->customer->login($data['email'], $this->request->post['password']);

				$this->redirect($this->url->link('account/account', '', 'SSL'));
			}

			$this->data['text_password'] = $this->language->get('text_password');

			$this->data['entry_password'] = $this->language->get('entry_password');
			$this->data['entry_confirm'] = $this->language->get('entry_confirm');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['key'] = $key;

			if (isset($this->error['password'])) {
				$this->data['error_password'] = $this->error['password'];
			} else {
				$this->data['error_password'] = '';
			}

			if (isset($this->error['confirm'])) {
				$this->data['error_confirm'] = $this->error['confirm'];
			} else {
				$this->data['error_confirm'] = '';
			}

			$this->data['action'] = $this->url->link('module/subscribe/confirmSubscribe', '', 'SSL');

			if (isset($this->request->post['password'])) {
				$this->data['password'] = $this->request->post['password'];
			} else {
				$this->data['password'] = '';
			}

			if (isset($this->request->post['confirm'])) {
				$this->data['confirm'] = $this->request->post['confirm'];
			} else {
				$this->data['confirm'] = '';
			}

			$this->data['text_message_confirm'] = $this->language->get('text_message_confirm');
		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/subscribe.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/subscribe.tpl';
		} else {
			$this->template = 'default/template/account/subscribe.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	private function validatePassword() {
		if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
			$this->error['password'] = $this->language->get('error_password');
		}

		if ($this->request->post['confirm'] != $this->request->post['password']) {
			$this->error['confirm'] = $this->language->get('error_confirm');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function keyValidate($key) {
		if (isset($key) && !$this->getDataSubscriber($key)) {
			$this->error['warning'] = sprintf($this->language->get('text_message_error'), $this->url->link('information/contact'));
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function getDataSubscriber($key) {
		$data = array();

		foreach ($this->model_catalog_subscribe->checkCustomers() as $customer) {
			if ($this->keyDecoding($customer['email']) == $key && !$customer['approved']) {
				$data = array(
					'customer_id' => $customer['customer_id'],
					'email' => $customer['email'],
					'approved' => $customer['approved']
				);

				break;
			}
		}

		return $data;
	}

	private function keyCoding($key) {
		$password = md5($key);

		return $password;
	}

	private function keyDecoding($key) {
		$password = md5($key);

		return $password;
	}

}

?>
