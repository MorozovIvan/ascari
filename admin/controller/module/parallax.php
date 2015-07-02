<?php
class ControllerModuleParallax extends Controller {

    private $_name = 'parallax';

	private $error = array(); 
	 
	public function index() {   
		$this->load->language('module/parallax');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addStyle('view/javascript/parallax/css/bottstrap.css');
        $this->document->addScript('view/javascript/parallax/js/bootstrap.min.js');
        $this->document->addScript('view/javascript/parallax/js/bootstrap-colorpicker.js');
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('parallax', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] 		 = $this->language->get('heading_title');
		
		$this->data['text_enabled'] 		 = $this->language->get('text_enabled');
		$this->data['text_disabled'] 		 = $this->language->get('text_disabled');
		$this->data['text_content_top'] 	 = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] 	 = $this->language->get('text_content_bottom');	
		$this->data['text_content_middle'] 	 = $this->language->get('text_content_middle');		
		
        $this->data['show_title'] 			 = $this->language->get('show_title');		
		$this->data['entry_description']  	 = $this->language->get('entry_description');
		$this->data['entry_layout'] 		 = $this->language->get('entry_layout');
		$this->data['entry_position'] 	 	 = $this->language->get('entry_position');
		$this->data['entry_status'] 		 = $this->language->get('entry_status');
		$this->data['entry_sort_order'] 	 = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] 			 = $this->language->get('button_save');
		$this->data['button_cancel'] 		 = $this->language->get('button_cancel');
		$this->data['button_add_module'] 	 = $this->language->get('button_add_module');
		$this->data['button_remove'] 		 = $this->language->get('button_remove');
		
		$this->data['slider_yes'] 			 = $this->language->get('slider_yes');
		$this->data['slider_no'] 			 = $this->language->get('slider_no');
		
		$this->data['products_settings'] 	 = $this->language->get('products_settings');
		$this->data['change_product'] 		 = $this->language->get('change_product');
		$this->data['selected_products']     = $this->language->get('selected_products');
		$this->data['product_description']   = $this->language->get('product_description');
		$this->data['product_description_s'] = $this->language->get('product_description_s');
		$this->data['image_size']            = $this->language->get('image_size');
		
		$this->data['slider_settings']       = $this->language->get('slider_settings');
		$this->data['slider_bg']             = $this->language->get('slider_bg');
		$this->data['slider_bg_pattern']     = $this->language->get('slider_bg_pattern');
		$this->data['slider_stick_color']    = $this->language->get('slider_stick_color');
		$this->data['slider_stick_ncolor']   = $this->language->get('slider_stick_ncolor');
		$this->data['slider_stick_ocolor']   = $this->language->get('slider_stick_ocolor');
		$this->data['slider_text_color']     = $this->language->get('slider_text_color');
		$this->data['slider_text_size']      = $this->language->get('slider_text_size');
		$this->data['slider_title_color']    = $this->language->get('slider_title_color');
		$this->data['slider_title_size']     = $this->language->get('slider_title_size');
		$this->data['slider_buttons']        = $this->language->get('slider_buttons');
		$this->data['slider_interval']       = $this->language->get('slider_interval');
		$this->data['slider_bgincrement']    = $this->language->get('slider_bgincrement');
		$this->data['slider_autoplay']       = $this->language->get('slider_autoplay');
		$this->data['slider_size'] 		     = $this->language->get('slider_size');
		$this->data['position_settings']     = $this->language->get('position_settings');
		
		$this->data['tab_module'] = $this->language->get('tab_module');
		
		$this->data['token'] = $this->session->data['token'];

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
			'href'      => $this->url->link('module/parallax', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/parallax', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		if (isset($this->request->post['parallax_module'])) {
			$this->data['modules'] = $this->request->post['parallax_module'];
		} elseif ($this->config->get('parallax_module')) { 
			$this->data['modules'] = $this->config->get('parallax_module');
		}	

		$this->load->model('catalog/product');
      
// add product
    foreach ($this->data['modules'] as $module=>$info) {
         		$prods = explode(',', $info['products_ids']);
                        $this->data['modules'][$module]['products'] = array();

                        foreach ($prods as $product_id) {
         			$product_info = $this->model_catalog_product->getProduct($product_id);
         			if ($product_info) {
         				$this->data['modules'][$module]['products'][] = array(
         					'product_id' => $product_info['product_id'],
         					'name'       => $product_info['name']
         				);
         			}
         		}
       
    }

// slider_pattern
		$this->data['slider_pattern'] = array();
		
		$this->data['slider_pattern'][] = array(
			'pattern' => 'none',
			'title'  => 'none',
		);
        $this->data['slider_pattern'][] = array(
			'pattern' => 'burlap.png',
			'title'  => 'burlap.png',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'circles.png',
			'title'  => 'circles.png',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'digital.png',
			'title'  => 'digital',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'elegant.png',
			'title'  => 'elegant',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'grunge-1.png',
			'title'  => 'grunge 1',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'grunge-2.png',
			'title'  => 'grunge 2',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'isometric.png',
			'title'  => 'isometric',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'lines.png',
			'title'  => 'lines',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'square-wave.png',
			'title'  => 'square-wave',
		);
		$this->data['slider_pattern'][] = array(
			'pattern' => 'tape-worm.png',
			'title'  => 'tape-worm',
		);

// slider_button
		$this->data['slider_button'] = array();
		
		$this->data['slider_button'][] = array(
			'button' => 'btn-inverse',
			'title'  => 'black',
		);	
		$this->data['slider_button'][] = array(
			'button' => 'btn-primary',
			'title'  => 'blue',
		);
		$this->data['slider_button'][] = array(
			'button' => 'btn-info',
			'title'  => 'light blue',
		);
		$this->data['slider_button'][] = array(
			'button' => 'white',
			'title'  => 'white',
		);
		$this->data['slider_button'][] = array(
			'button' => 'btn-success',
			'title'  => 'green',
		);
		$this->data['slider_button'][] = array(
			'button' => 'btn-warning',
			'title'  => 'orange',
		);
		$this->data['slider_button'][] = array(
			'button' => 'btn-danger',
			'title'  => 'red',
		);
		
// slider_sticker
		$this->data['slider_sticker'] = array();
		
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_blue.png',
			'title'  => 'blue',
		);
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_red.png',
			'title'  => 'red',
		);
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_yellow.png',
			'title'  => 'yellow',
		);
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_white.png',
			'title'  => 'white',
		);
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_green.png',
			'title'  => 'green',
		);
		$this->data['slider_sticker'][] = array(
			'sticker' => 'stick_black.png',
			'title'  => 'black',
		);
			
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/parallax.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/parallax')) {
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