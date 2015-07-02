<?php  
class ControllerProductProductPopup extends Controller {
	public function index() {
		$json = array();
		if ($this->request->server['REQUEST_METHOD'] == 'POST' and isset($this->request->post['product_id'])) {
			$this->language->load('product/product');
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$product_info = $this->model_catalog_product->getProduct($this->request->post['product_id']);
			if ($product_info) {
				$this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
				$this->data['button_cart'] = $this->language->get('button_cart');
				$this->data['text_qty'] = $this->language->get('text_qty');
				$this->data['text_stock'] = $this->language->get('text_stock');
				$this->data['text_price'] = $this->language->get('text_price');
				$this->data['text_select'] = $this->language->get('text_select');
				$this->data['button_continue'] = $this->language->get('button_continue');
				$this->data['text_option'] = $this->language->get('text_option');
				$this->data['tab_description'] = $this->language->get('tab_description');
				$this->data['text_discount'] = $this->language->get('text_discount');
				$this->data['button_upload'] = $this->language->get('button_upload');
				
				$this->data['product_id'] = $this->request->post['product_id'];
				$this->data['name'] = !empty($product_info['seo_h1']) ? $product_info['seo_h1'] : $product_info['name'];
				$this->data['link'] = $this->url->link('product/product','product_id='.$this->request->post['product_id']);
				$this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
				
				if ($product_info['minimum']) {
					$this->data['minimum'] = $product_info['minimum'];
				} else {
					$this->data['minimum'] = 1;
				}
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$this->data['price'] = false;
				}
				if ((float)$product_info['special']) {
					$this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$this->data['special'] = false;
				}
				$this->data['options'] = array();
				foreach ($this->model_catalog_product->getProductOptions($this->request->post['product_id']) as $option) { 
					if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
						$option_value_data = array();
						foreach ($option['option_value'] as $option_value) {
							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
								if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
									$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
								} else {
									$price = false;
								}
								$option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
									'price'                   => $price,
									'price_prefix'            => $option_value['price_prefix']
								);
							}
						}
						$this->data['options'][] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option_value_data,
							'required'          => $option['required']
						);					
					} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
						$this->data['options'][] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option['option_value'],
							'required'          => $option['required']
						);						
					}
				}
				$discounts = $this->model_catalog_product->getProductDiscounts($this->request->post['product_id']);
				$this->data['discounts'] = array();
				foreach ($discounts as $discount) {
					$this->data['discounts'][] = array(
						'quantity' => $discount['quantity'],
						'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
					);
				}
				
				$this->data['images'] = array();
				
				if ($product_info['image']) {
					$this->data['images'][] = array(
						'popup' => $this->model_tool_image->resize($product_info['image'], 400, 400),
						'popup_zoom' => $this->model_tool_image->resize($product_info['image'], 900, 900),
						'thumb' => $this->model_tool_image->resize($product_info['image'], 90, 90)
					);
				} else {
					$this->data['images'][] = array(
						'popup' => $this->model_tool_image->resize('no_image.jpg', 400, 400),
						'popup_zoom' => $this->model_tool_image->resize('no_image.jpg', 900, 900),
						'thumb' => $this->model_tool_image->resize('no_image.jpg', 90, 90)
					);
				}
				
				$results = $this->model_catalog_product->getProductImages($this->request->post['product_id']);
				
				foreach ($results as $result) {
					$this->data['images'][] = array(
						'popup' => $this->model_tool_image->resize($result['image'], 400, 400),
						'popup_zoom' => $this->model_tool_image->resize($result['image'], 900, 900),
						'thumb' => $this->model_tool_image->resize($result['image'], 90, 90)
					);
				}
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product_popup.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/product/product_popup.tpl';
				} else {
					$this->template = 'default/template/product/product_popup.tpl';
				}
				
				$json['success'] = $this->render();
			} else {
				$json['redirect'] = $this->url->link('product/product','product_id='.$this->request->post['product_id']);
			}
		} else {
			$json['redirect'] = $this->url->link('common/home');
		}
		$this->response->setOutput(json_encode($json));
	}
}