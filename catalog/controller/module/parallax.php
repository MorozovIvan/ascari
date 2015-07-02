<?php  
class ControllerModuleParallax extends Controller {

    private $_name = 'parallax';
	private $_path = HTTPS_SERVER;

	protected function index($setting) {
                static $module = 0;

		$this->language->load('module/'.$this->_name);
		
		$this->document->addStyle($this->_path.'catalog/view/javascript/'.$this->_name.'/css/style.css', $rel = 'stylesheet', $media = 'screen');	
		$this->document->addScript($this->_path.'catalog/view/javascript/'.$this->_name.'/js/jquery.cslider.js');
		$this->document->addScript($this->_path.'catalog/view/javascript/'.$this->_name.'/js/modernizr.custom.28468.js');

		$this->data['text_sale']    		= $this->language->get('text_sale');
		$this->data['text_readmore'] 	    = $this->language->get('text_readmore');
    	
		$this->data['slider_bg'] 	    	= $setting['slider_bg'];
		$this->data['slider_pattern'] 		= $setting['slider_pattern'];
		$this->data['slider_sticker'] 	    = $setting['slider_sticker'];
		$this->data['sticker_ncolor'] 	    = $setting['sticker_ncolor'];
		$this->data['sticker_ocolor'] 	    = $setting['sticker_ocolor'];
		$this->data['slider_tcolor'] 		= $setting['slider_tcolor'];
		$this->data['slider_hcolor'] 		= $setting['slider_hcolor'];
		$this->data['slider_tsize'] 		= $setting['slider_tsize'];
		$this->data['slider_hsize'] 		= $setting['slider_hsize'];	
		$this->data['slider_button'] 		= $setting['slider_button'];
		$this->data['slider_interval'] 	    = $setting['slider_interval'];
		$this->data['slider_bgincrement'] 	= $setting['slider_bgincrement'];
		$this->data['slider_autoplay'] 		= $setting['slider_autoplay'];
		
		$this->data['slider_width'] 		= $setting['slider_width'];
		$this->data['slider_height'] 		= $setting['slider_height'];

		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();
		$this->data['show_description'] 	= $setting['show_description'];
		$this->data['show_bg'] 				= $setting['show_bg'];
		$this->data['image_width'] 			= $setting['image_width'];
		$this->data['image_height'] 		= $setting['image_height'];

		$products = explode(',', $setting['products_ids']);		

		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
					
				$this->data['products'][] = array(
					'product_id'	=> $product_info['product_id'],
					'thumb'		=> $image,
					'name'    	=> $product_info['name'],
					'price'   	=> $price,
					'special' 	=> $special,
					'description'	=> substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['description_length']) . '..',
					'reviews'   	=> sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	=> $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
				);
			}
		}

		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/'.$this->_name.'.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/'.$this->_name.'.tpl';
		} else {
			$this->template = 'default/template/module/'.$this->_name.'.tpl';
		}
		
		$this->render();
	}
}
?>