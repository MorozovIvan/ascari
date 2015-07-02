<?php
if (!class_exists('AddistObject')) require_once(DIR_SYSTEM.'addist/startup.php');
class ControllerModuleAddistInstaller extends Controller
{
    public $path        = 'module/addist_installer/addist_installer';
    public $data        = array();
    public $errors      = false;
    
	public function __get($key)
    {
        if ($key=='installer')
		{
            $installer = $this->registry->get('installer');
            if (empty($installer))
            {
                $installer = new AddistInstaller($this->registry);
                $this->registry->set('installer', $installer);
            }
		}
        
        return parent::__get($key);
	}
    
    public function __construct($registry)
    {
        parent::__construct($registry);
        
        $this->language->load('common/addist');
        $this->language->load('module/addist_installer');
        
        $errors = check_requirements(false);
        if (is_array($errors))
        {
            $this->errors = $errors;
            if ($this->request->get['route'] != 'module/addist_installer')
            {
                if (OC_VERSION == '2.0.x')
                {
                    $this->response->redirect($this->url->link('module/addist_installer', 'token=' . $this->session->data['token'], 'SSL'));
                }
                else
                {
                    $this->redirect($this->url->link('module/addist_installer', 'token=' . $this->session->data['token'], 'SSL'));
                }
            }
        }
        else
        {
            require_once(DIR_SYSTEM . 'addist/library/installer.php');
            $this->registry->set('installer',new AddistInstaller($this->registry));
        }
    }
    
    public function __call($method,$args)
    {
        if (empty($this->errors))
        {
            return call_user_func_array(array($this->installer,$method),$args);
        }
    }
    
    public function install()
    {
        if (empty($this->errors))
        {
            return call_user_func_array(array($this->installer,'install'),array());
        }
    }
    
    public function index()
    {
        if (empty($this->errors))
        {
            return call_user_func_array(array($this->installer,'index'),array());
        }
        else
        {
            $this->data['heading_title'] = $this->language->get('heading_title');
            $this->data['errors'] = $this->errors;
            $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
            
            if (OC_VERSION == '2.0.x')
            {
                return $this->load->controller('addist/error',$this->data);
            }
            else
            {
                return $this->getChild('addist/error',$this->data);
            }
        }
	}
}
?>