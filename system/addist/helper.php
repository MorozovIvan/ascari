<?php
//error page
function addist_error($errors)
{
    global $registry, $response, $document, $language, $url, $session, $loader;
    
    $data['errors'] = $errors;
    
    if (OC_VERSION == '2.0.x')
    {
        return $loader->load->controller('addist/error',$data);
    }
    else
    {
        $action = new Action('addist/error');
        
		require_once($action->getFile());

		$class = $action->getClass();

		$controller = new $class($registry);

		$controller->{$action->getMethod()}($data);

        $response->setOutput($controller->render());
    }
    $response->output();
}

//check requirements function
function check_requirements($force = true)
{
    if (ob_get_contents())
    {
        ob_clean();
    }
    global $language;
    $errors = array();
    
    //checking ioncube
    $extensions = get_loaded_extensions();
    if (in_array('ionCube Loader', $extensions))
    {
        if (version_compare(ioncube_loader_version(),IONCUBE_VERSION) < 0)
        {
            $errors[] = sprintf($language->get('addist_error_ioncube_version'),IONCUBE_VERSION);
        }
    }
    else
    {
        $errors[] = $language->get('addist_error_ioncube');
    }
    
    //checking vqmod
    if (OC_VERSION != '2.0.x')
    {
        if (!class_exists('VQMod'))
        {
            $errors[] = $language->get('addist_error_vqmod');
        }
        else
        {
            $vqm = new ReflectionClass('VQMod');
            if ($vqm->isAbstract())
            {
                if (version_compare(VQMod::$_vqversion,VQMOD_VERSION) < 0)
                {
                    $errors[] = sprintf($language->get('addist_error_vqmod_version'),VQMOD_VERSION);
                }
            }
            else
            {
                $rp = new ReflectionProperty(new VQMod(),'_vqversion');
                if (!$rp->isStatic() || $rp->isPrivate())
                {
                    $errors[] = sprintf($language->get('addist_error_vqmod_version'),VQMOD_VERSION);
                }
            }
        }
    }
    
    if ($errors)
    {
        if ($force)
        {
            addist_error($errors);
        }
        else
        {
            return $errors;
        }
    }
    else
    {
        return true;
    }
}

//adutoload
function addist_autoload($class)
{
    $class = strtolower($class);
    if (substr($class,0,6) == 'addist')
    {
        check_requirements(true);
        $filename = DIR_SYSTEM . 'addist/engine/'.substr($class,6,strlen($class)).'.php';
        if (file_exists($filename))
        {
            require_once($filename);
        }
        
        $filename = DIR_SYSTEM . 'addist/library/'.substr($class,6,strlen($class)).'.php';
        if (file_exists($filename))
        {
            require_once($filename);
        }
    }
}
    
function addMessage($type, $message, $replace = false)
{
    global $session;
    
    if ($replace)
    {
        $session->data[$type] = trim($message);
    }
    else
    {
        if ($type !='error' || ($type=='error' && empty($session->data[$type])))
        {
            if (isset($session->data[$type]))
            {
                if (substr_count($session->data[$type],trim($message))==0)
                {
                    $session->data[$type] = trim($message).'<br/>'.$session->data[$type];
                }
            }
            else
            {
                $session->data[$type] = trim($message).'<br/>';
            }
        }
    }
}

function getStores()
{
    global $db;
    
    $stores = array();
    
    $query = $db->query("SELECT `value` FROM `".DB_PREFIX."setting` WHERE `store_id` = '0' AND `key` = 'config_name'");
    $stores[] = array('store_id'=>'0','name'=>$query->row['value']);
    
    $query = $db->query("SELECT * FROM `".DB_PREFIX."store`");
    foreach($query->rows as $row)
    {
        $stores[] = $query->row;
    }
    
    return $stores;
}

function addLog($message, $filename = 'error')
{
    $handle = fopen(DIR_LOGS . $filename . '.log', 'a');
    fwrite($handle, date('Y-m-d G:i:s') . ' - ' . print_r($message, true) . "\n");
    fclose($handle);
}

function readLog($filename = 'error')
{
    if (is_file(DIR_LOGS.$filename.'.log'))
    {
        return file_get_contents(DIR_LOGS.$filename.'.log');
    }
}
?>