<?php  
class ControllerModuleAlternative extends Controller {
	
	protected function index($setting) {
		
		//����������� �������� ������
		$this->language->load('module/alternative');
		
		//����������� ���� �������
		$this->load->model('module/alternative');
		$this->load->model('tool/image');
		
		//����������� ������
		$this->document->addStyle('catalog/view/theme/default/stylesheet/alternative.css');
		$this->document->addStyle('catalog/view/theme/default/stylesheet/carousel.css');
		
		//����������� ��������
		$this->document->addScript('catalog/view/javascript/jquery/jquery.jcarousel.min.js');

        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');

		//����������� Id ������
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = $this->model_module_alternative->getProductId();
		}
		
		//����������� Id ���������, � ������� ����������� ������� �����
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)end($parts);
			$path = $this->request->get['path'];
		} else {
			$category_id = $this->model_module_alternative->getProductCategoryId($product_id);
			$path = $category_id;
		}	
		
		//������ � ������� ������
		$this_product = $this->model_module_alternative->getProduct($product_id);
		$this_price = (int)$this_product['price'];
		$this_manufacture = (int)$this_product['manufacturer_id'];
		$manufacture = (isset($setting['manufacture'])) ? true : false;
		
		//������ �������������� �������
		$results = $this->model_module_alternative->getAlternativeProducts($product_id, $category_id, $this_price, $this_manufacture, (int)$setting['type_id'], (int)$setting['attribute_id'], $manufacture);
		
		//�������� �������� ������ �� ������
		unset($results[$product_id]);
		
		//���������� ��� �������
		$this->data['heading_title'] = $setting['title'];
		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['limit'] = $setting['limit'];
		$this->data['products'] = array();

		//������������ ������ ������� ��� ������ � ������
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
					
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}	
			
			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}
							
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
				'rating'     => $rating,
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'path='.$path.'&product_id='.$result['product_id']),
			);
		}
		
		//���������� ������
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/alternative.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/alternative.tpl';
		} else {
			$this->template = 'default/template/module/alternative.tpl';
		}

		$this->render();
  	}
	
}
?>