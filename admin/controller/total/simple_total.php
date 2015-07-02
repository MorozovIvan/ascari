<?php 
class ControllerTotalSimpleTotal extends Controller { 
    private $error = array(); 
     
    public function index() { 
        $this->load->language('total/simple_total');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            $this->model_setting_setting->editSetting('simple_total', $this->request->post);
        
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        $this->data['heading_title']      = $this->language->get('heading_title');
        
        $this->data['text_enabled']       = $this->language->get('text_enabled');
        $this->data['text_disabled']      = $this->language->get('text_disabled');
        
        $this->data['entry_custom_id']    = $this->language->get('entry_custom_id');
        $this->data['entry_custom_help']  = $this->language->get('entry_custom_help');
        $this->data['entry_custom_value'] = $this->language->get('entry_custom_value');
        $this->data['entry_total_label']  = $this->language->get('entry_total_label');
        $this->data['entry_total_value']  = $this->language->get('entry_total_value');
        $this->data['entry_status']       = $this->language->get('entry_status');
        $this->data['entry_sort_order']   = $this->language->get('entry_sort_order');
        
        $this->data['button_save']        = $this->language->get('button_save');
        $this->data['button_cancel']      = $this->language->get('button_cancel');

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
            'text'      => $this->language->get('text_total'),
            'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),              
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('total/simple_total', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('total/simple_total', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->request->post['simple_total_custom_id'])) {
            $this->data['simple_total_custom_id'] = $this->request->post['simple_total_custom_id'];
        } else {
            $this->data['simple_total_custom_id'] = $this->config->get('simple_total_custom_id');
        }

        if (isset($this->request->post['simple_total_custom_value'])) {
            $this->data['simple_total_custom_value'] = $this->request->post['simple_total_custom_value'];
        } else {
            $this->data['simple_total_custom_value'] = $this->config->get('simple_total_custom_value');
        }

        if (isset($this->request->post['simple_total_label'])) {
            $this->data['simple_total_label'] = $this->request->post['simple_total_label'];
        } else {
            $this->data['simple_total_label'] = $this->config->get('simple_total_label');
        }

        if (isset($this->request->post['simple_total_value'])) {
            $this->data['simple_total_value'] = $this->request->post['simple_total_value'];
        } else {
            $this->data['simple_total_value'] = $this->config->get('simple_total_value');
        }

        if (isset($this->request->post['simple_total_status'])) {
            $this->data['simple_total_status'] = $this->request->post['simple_total_status'];
        } else {
            $this->data['simple_total_status'] = $this->config->get('simple_total_status');
        }

        if (isset($this->request->post['simple_total_sort_order'])) {
            $this->data['simple_total_sort_order'] = $this->request->post['simple_total_sort_order'];
        } else {
            $this->data['simple_total_sort_order'] = $this->config->get('simple_total_sort_order');
        }

        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();
        $this->data['languages'] = array();
        foreach ($languages as $language) {
            $language['code'] = str_replace('-', '_', strtolower($language['code']));
            $this->data['languages'][] = $language;
        }

        $current_language = strtolower($this->config->get('config_admin_language'));
        $tmp = $this->config->get('simple_fields_custom');
        $this->data['custom_fields'] = array();
        foreach ($tmp as $key => $value) {
            $this->data['custom_fields'][$value['object_type'].'.'.$key] = !empty($value['label'][$current_language]) ? $value['label'][$current_language] : $key;
        }

        $this->template = 'total/simple_total.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'total/simple_total')) {
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