<?php
class ControllerModuleAlternative extends Controller {
	
	//Ошибки
	private $error = ''; 
	
	//Конструктор
	public function index() {   
		
		//Подключение языковых файлов
		$this->load->language('module/alternative');
		
		//Подключение моделей
		$this->load->model('setting/setting');
		$this->load->model('design/layout');
		$this->load->model('catalog/attribute');
		$this->load->model('catalog/attribute_group');
		
		//Заголовок страницы
		$this->document->setTitle($this->language->get('heading_title'));
	
		//Сохранение данных модуля
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('alternative', $this->request->post);		
			$this->session->data['success'] = $this->language->get('text_success');						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		//Данные для вывода в шаблон
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_manufacture'] = $this->language->get('entry_manufacture');
		$this->data['entry_title'] = $this->language->get('entry_title');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		//Ошибки
 		if ($this->error) {
			$this->data['error_warning'] = $this->error;
		} else {
			$this->data['error_warning'] = '';
		}
		
		//Хлебные крошки
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
			'href'      => $this->url->link('module/alternative', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		//Кнопки Добавить модуль и Удалить
		$this->data['action'] = $this->url->link('module/alternative', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		//Данные модуля
		if (isset($this->request->post['alternative_module'])) {
			$this->data['modules'] = $this->request->post['alternative_module'];
		} elseif ($this->config->get('alternative_module')) { 
			$this->data['modules'] = $this->config->get('alternative_module');
		} else {
			$this->data['modules'] = array();
		}
		
		//Критерий выбора товаров
		$this->data['types'] = array(
			array('type_id' => 0, 'name' => $this->language->get('text_category')),
			array('type_id' => 1, 'name' => $this->language->get('text_attribute'))
		);
		
		//Список всех атрибутов
		$attribute_groups = $this->model_catalog_attribute_group->getAttributeGroups();
		$all_attributes = array();
		foreach ($attribute_groups as $attribute_group) {			
			$attr_group = array(
				'attribute_group_id' => $attribute_group['attribute_group_id'],
				'name' => $attribute_group['name'],
				'attributes' => array()
			);
			$attrs = $this->model_catalog_attribute->getAttributesByAttributeGroupId(array('filter_attribute_group_id'=>(int)$attribute_group['attribute_group_id']));
			foreach ($attrs as $attr) {
				$attr_group['attributes'][] = array(
					'attribute_id' => $attr['attribute_id'],
					'name' => $attr['name']
				);
			}
			$all_attributes[] = $attr_group;		
		}
		
		$this->data['attributes'] = array();
		foreach ($all_attributes as $x=>$attribute_group) {
			foreach ($attribute_group['attributes'] as $y=>$attribute) {
				$this->data['attributes'][] = array(
					'attribute_id' => $attribute['attribute_id'],
					'name'		   => $attribute_group['name'].' > '.$attribute['name']
				);
			}
		}
		
		//Схемы
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		//Шаблон
		$this->template = 'module/alternative.tpl';
		
		//Подключение шапки и подвала страницы
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render());
	}
	
	//Проверка на ошибки
	private function validate() {
		
		//Проверка на права редактировать модуль
		if (!$this->user->hasPermission('modify', 'module/alternative')) {
			$this->error .= $this->language->get('error_permission').'<br>';
		}
		
		if (isset($this->request->post['alternative_module'])) {
			foreach ($this->request->post['alternative_module'] as $key => $value) {
				
				//Проверка на пустую ширина или высота изображения
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error .= $this->language->get('error_image').'<br>';
				}
				
				//Проверка на пустое значение лимита
				if (!$value['limit']) {
					$this->error .= $this->language->get('error_limit').'<br>';
				}
				
			}
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
		
	}
}
?>