<?php
#encode-me[]#
if (!class_exists('AddistObject')) require_once(DIR_SYSTEM.'addist/startup.php');
class ControllerModuleExtManager extends AddistController
{
    protected $path = 'module/ext_manager/ext_manager';
    
    protected $dirproblem   = false;
    
    public function __construct($registry)
    {
        parent::__construct($registry);
        
        mb_internal_encoding('UTF-8');
        
        $this->load_language('module/ext_manager');
        
        if(!file_exists(DIR_APPLICATION.'../extensions')||!is_dir(DIR_APPLICATION.'../extensions'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('error_directory'),'extensions'));
        }
        elseif (!is_writable(DIR_APPLICATION.'../extensions'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('addist_error_chmod'),'extensions'));
        }
        
        if(!file_exists(DIR_APPLICATION.'../extensions/backup')||!is_dir(DIR_APPLICATION.'../extensions/backup'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('error_directory'),'extensions/backup'));
        }
        elseif (!is_writable(DIR_APPLICATION.'../extensions/backup'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('addist_error_chmod'),'extensions/backup'));
        }
        
        if(!file_exists(DIR_APPLICATION.'../extensions/history')||!is_dir(DIR_APPLICATION.'../extensions/history'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('error_directory'),'extensions/history'));
        }
        elseif (!is_writable(DIR_APPLICATION.'../extensions/history'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('addist_error_chmod'),'extensions/history'));
        }
        
        if(!file_exists(DIR_APPLICATION.'../extensions/temp')||!is_dir(DIR_APPLICATION.'../extensions/temp'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('error_directory'),'extensions/temp'));
        }
        elseif (!is_writable(DIR_APPLICATION.'../extensions/temp'))
        {
            $this->dirproblem = true;
            addMessage('error',sprintf($this->language->get('addist_error_chmod'),'extensions/temp'));
        }
    }
    
    public function index()
    {
        if (isset($this->request->get['download']))
        {
            $file = DIR_APPLICATION.'../extensions/backup/'.$this->request->get['download'].'.zip';
            
            if (file_exists($file))
            {
                header("Content-type: application/octet-stream");
                header("Content-Disposition: attachment; filename=".$this->request->get['download'].".zip");
                header("Pragma: no-cache");
                header ("Expires: 0");
                echo file_get_contents($file);
            }
        }
        
        //title
		$this->document->setTitle($this->language->get('heading_title'));
        
        //get url data
		if (!isset($this->request->get['page'])) {
			$this->request->get['page'] = 1;
		}
        
        $url = '';
        
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		} else {
            $this->request->get['filter_name'] = null;
        }
        
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		} else {
            $this->request->get['filter_date'] = null;
        }
        
		if (isset($this->request->get['filter_version'])) {
			$url .= '&filter_version=' . $this->request->get['filter_version'];
		} else {
            $this->request->get['filter_version'] = null;
        }
        
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
            $this->request->get['filter_status'] = null;
        }
        
		$this->data['filter_name'] = $this->request->get['filter_name'];
        $this->data['filter_date'] = $this->request->get['filter_date'];
        $this->data['filter_version'] = $this->request->get['filter_version'];
		$this->data['filter_status'] = $this->request->get['filter_status'];
        $this->data['page'] = $this->request->get['page'];
        
        $this->data['statuses'] = array(
            $this->language->get('text_not_installed'),
            $this->language->get('text_not_fully_installed'),
            $this->language->get('text_installed'),
            $this->language->get('text_deleted'),
        );
        
        //filter data
        $xmls = (array)glob(DIR_APPLICATION.'../extensions/*.xml');
        $files = array_reverse($xmls);
        
        $items = array();
        if ($files)
        {
            foreach($files as $file)
            {
                if (empty($file)) continue;
                $xmlString = trim(file_get_contents($file));
                if (empty($xmlString)) continue;
                $xml = new SimpleXMLElement($xmlString);
                if ($xml)
                {
                    $items[] = array(
                        'name'          =>      $xml->name,
                        'filename'      =>      basename($file),
                        'version'       =>      $xml->version,
                        'title'         =>      $xml->title,
                        'timestamp'     =>      isset($xml->time_update) ? trim($xml->time_update) : trim($xml->time),
                        'time'          =>      date('d-m-Y H:i:s',trim($xml->time)),
                        'time_update'   =>      isset($xml->time_update) ? date('d-m-Y H:i:s',trim($xml->time_update)) : '',
                        'installed'     =>      $this->checkInstall($xml),
                        'view_url'      =>      $this->url->link('module/ext_manager/view', 'filename='.trim($xml->time).'&token=' . $this->session->data['token'], 'SSL'),
                        'update_url'    =>      $this->url->link('module/ext_manager/upload', 'filename='.trim($xml->time).'&token=' . $this->session->data['token'], 'SSL'),
                        'restore_url'   =>      $this->url->link('module/ext_manager/restore', 'filename='.trim($xml->time).'&token=' . $this->session->data['token'], 'SSL'),
                        'remove_url'    =>      $this->url->link('module/ext_manager/remove', 'filename='.trim($xml->time).'&token=' . $this->session->data['token'], 'SSL'),
                        'backup_url'    =>      $this->url->link('module/ext_manager/backup', 'filename='.trim($xml->time).'&token=' . $this->session->data['token'], 'SSL'),
                    );
                }
            }
        }
        
        usort($items,function($a,$b){return $b['timestamp']-$a['timestamp'];});
        
        mb_internal_encoding('UTF-8');
        $extensions = array_filter($items,function($var)
        {
            if (isset($_GET['filter_name']) && substr_count(mb_strtolower(trim($var['title'])),mb_strtolower($_GET['filter_name'])) == 0)
            {
                return false;
            }
            if (isset($_GET['filter_date']))
            {
                $filter_date = trim($_GET['filter_date']);
                $install_date = date('Y-m-d',strtotime(trim($var['time'])));
                if ($filter_date != $install_date)
                {
                    return false;
                }
            }
            if (isset($_GET['filter_version']))
            {
                $file_version = explode('.',trim($var['version']));
                $filter_version = explode('.',$_GET['filter_version']);
                
                foreach($filter_version as $i=>$part)
                {
                    if ($file_version[$i] != $part)
                    {
                        return false;
                    }
                }
            }
            if (isset($_GET['filter_status']))
            {
                if ((int)trim($var['installed'])!=(int)trim($_GET['filter_status']))
                {
                    return false;
                }
            }
            return true;
        });
        
        $extensions = array_slice($extensions,($this->request->get['page']-1)*$this->config->get('config_admin_limit'),$this->config->get('config_admin_limit'));
        
        $this->data['extensions'] = $extensions;
        
        $this->data['action_upload'] = $this->url->link('module/ext_manager/upload', 'token=' . $this->session->data['token'], 'SSL');
        
        //pagination
		$pagination = new AddistPagination();
		$pagination->total = count($files);
		$pagination->page = $this->request->get['page'];
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/ext_manager', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$this->data['pagination'] = $pagination->render();
        
        //set templates
		$this->template = 'module/ext_manager.tpl';
        
        //output
		$this->setOutput();
    }
    
    public function upload()
    {
        $error = false;
        
        $this->data['files'] = array();
        if (isset($this->request->get['filename']) && $this->request->get['filename'])
        {
            $file_xml = DIR_APPLICATION.'../extensions/'.$this->request->get['filename'].'.xml';
            if (file_exists($file_xml)&&is_file($file_xml))
            {
                $xmlString = file_get_contents($file_xml);
                $xml = new SimpleXMLElement($xmlString);
                $this->data['upload_filename'] = $this->request->get['filename'];
                $this->data['upload_name'] = $xml->title;
                $this->data['upload_version'] = $xml->version;
                $this->data['header_text'] = sprintf($this->language->get('text_update'),trim($xml->title),date("Y-m-d H:s:i",trim($xml->time)));
                
                $files = (array)$xml->files;
                $files = $files['file'];
                sort($files);
                $this->data['files'] = $files;
            }
            else
            {
                addMessage('error',$this->language->get('error_no_xml_extension'));
                $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
            }
        }
        elseif (isset($this->request->post['filename']) && $this->request->post['filename'])
        {
            $this->data['upload_filename'] = $this->request->post['filename'];
            $this->data['upload_name'] = $this->request->post['name'];
            $this->data['upload_version'] = $this->request->post['version'];
        }
        else
        {
            $filename = time();
            $this->data['upload_filename'] = '';
            $this->data['upload_name'] = '';
            $this->data['upload_version'] = '';
        }
        
        //post
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && isset($_FILES['file']) && $this->validate())
        {
            $file = DIR_APPLICATION.'../extensions/temp/'.md5($_FILES['file']['name']).'.'.$this->getExt($_FILES['file']['name']);
            
            if (file_exists(DIR_APPLICATION.'../extensions/temp/') && is_dir(DIR_APPLICATION.'../extensions/temp/') && move_uploaded_file($_FILES['file']['tmp_name'], $file))
            {
                $xml_str = '<?xml version="1.0" encoding="utf-8"?>'."\n";
                $xml_str .= '<extension>'."\n";
                $xml_str .= '   <title>'.$this->request->post['name'].'</title>'."\n";
                $xml_str .= '   <time>'.$filename.'</time>'."\n";
                if ($this->request->post['filename'])
                {
                    $xml_str .= '   <time_update>'.time().'</time_update>'."\n";
                }
                $xml_str .= '   <version>'.$this->request->post['version'].'</version>'."\n";
                $xml_str .= '   <files>'."\n";
                
                $zip = new ZipArchive();
                
                $zip->open($file);
                
                $files = '';
                $replace = '';
                
                for( $i = 0; $i < $zip->numFiles; $i++ )
                {
                    $stat = $zip->statIndex($i);
                    
                    if ($stat['size'] > 0)
                    {
                        $check_file = DIR_APPLICATION.'../'.$stat['name'];
                        if (file_exists($check_file) && is_file($check_file))
                        {
                            if (!is_writable($check_file))
                            {
                                $error = true;
                                addMessage('error',sprintf($this->language->get('addist_error_write'),$stat['name']));
                            }
                        }
                    }
                    else
                    {
                        $check_folder = DIR_APPLICATION.'../'.$stat['name'];
                        if (file_exists($check_folder) && is_dir($check_folder))
                        {
                            if (!is_writable($check_folder))
                            {
                                $error = true;
                                addMessage('error',sprintf($this->language->get('addist_error_chmod'),$stat['name']));
                            }
                        }
                    }
                }
                
                if (!$error)
                {
                    for( $i = 0; $i < $zip->numFiles; $i++ )
                    {
                        $stat = $zip->statIndex($i);
                        
                        if ($stat['size'] > 0)
                        {
                            $files .= '       <file>'.$stat['name'].'</file>'."\n";
                        }
                        
                        if ($this->request->post['type'] == 'install')
                        {
                            if (empty($this->request->post['exclude']) || in_array($stat['name'],$this->request->post['exclude']))
                            {
                                if (file_exists(DIR_APPLICATION.'../'.$stat['name']) && is_file(DIR_APPLICATION.'../'.$stat['name']))
                                {
                                    if (substr(basename($stat['name']),0,6) == 'addist') continue;
                                    
                                    $replace .= '       <replaced>'.$stat['name'].'</replaced>'."\n";
                                    if (!file_exists(DIR_APPLICATION.'../extensions/history/'.$filename.'/'.dirname($stat['name'])) && !is_dir(DIR_APPLICATION.'../extensions/history/'.$filename.'/'.dirname($stat['name'])))
                                    {
                                        mkdir(DIR_APPLICATION.'../extensions/history/'.$filename.'/'.dirname($stat['name']),0777,true);
                                    }
                                    copy(DIR_APPLICATION.'../'.$stat['name'],DIR_APPLICATION.'../extensions/history/'.$filename.'/'.$stat['name']);
                                }
                            }
                            else
                            {
                                $zip->deleteIndex($i);
                            }
                        }
                    }
                }
                
                $xml_str .= $files;
                $xml_str .= $replace;
                $xml_str .= '   </files>'."\n";
                $xml_str .= '</extension>'."\n";
            }
            else
            {
                $error = true;
                addMessage('error',$this->language->get('error_upload'));
            }
            
            if (!$error)
            {
                if ($this->request->post['type'] == 'install')
                {
                    $zip->extractTo(DIR_APPLICATION.'../');
                    $zip->close();
                    unlink($file);
                }
                file_put_contents(DIR_APPLICATION.'../extensions/'.$filename.'.xml', $xml_str);
                addMessage('success',$this->language->get('success_uploaded'));
                sleep(3);
                $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
            }
            else
            {
                $zip->close();
                unlink($file);
            }
		}
        
        //title
		$this->document->setTitle($this->language->get('heading_title'));
        
        $this->data['action_upload'] = $this->url->link('module/ext_manager/upload', 'token=' . $this->session->data['token'], 'SSL');
        
        //set templates
		$this->template = 'module/ext_manager_upload.tpl';
        
        //output
		$this->setOutput();
    }
    
    public function view()
    {
        $error = false;
        
        //title
		$this->document->setTitle($this->language->get('heading_title'));
        
        $filename = $this->request->get['filename'];
        $file_xml = DIR_APPLICATION.'../extensions/'.$filename.'.xml';
        if (file_exists($file_xml)&&is_file($file_xml))
        {
            $xmlString = file_get_contents($file_xml);
            $xml = new SimpleXMLElement($xmlString);
            
            $this->data['files'] = array();
            $this->data['replaced'] = array();
            if ($xml->files)
            {
                if ($xml->files->file)
                {
                    foreach($xml->files->file as $file)
                    {
                        $this->data['files'][] = $file;
                    }
                }
                if ($xml->files->replaced)
                {
                    foreach($xml->files->replaced as $replaced)
                    {
                        $this->data['replaced'][] = $replaced;
                    }
                }
            }
            
            $this->data['header_text'] = sprintf($this->language->get('text_view'),trim($xml->title),date("Y-m-d H:s:i",isset($xml->time_update) ? trim($xml->time_update) : trim($xml->time)));
        }
        else
        {
            addMessage('error',$this->language->get('error_no_xml_extension'));
            $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        //set templates
		$this->template = 'module/ext_manager_view.tpl';
        
        //output
		$this->setOutput();
    }
    
    public function restore()
    {
        $error = false;
        $filename = DIR_APPLICATION.'../extensions/'.$this->request->get['filename'].'.xml';
        if(file_exists($filename)&&is_file($filename))
        {
            $xmlString = file_get_contents($filename);
            $xml = new SimpleXMLElement($xmlString);
            if ($xml)
            {
                foreach($xml->files->file as $file)
                {
                    if (substr(basename($file),0,6) == 'addist') continue;
                    if (!unlink(DIR_APPLICATION.'../'.$file))
                    {
                        $error = true;
                        addMessage('error',sprintf($this->language->get('error_delete'),$file));
                    }
                }
                foreach($xml->files->replaced as $file)
                {
                    if (substr(basename($file),0,6) == 'addist') continue;
                    if (!copy(DIR_APPLICATION.'../extensions/history/'.trim($xml->time).'/'.$file,DIR_APPLICATION.'../'.$file))
                    {
                        $error = true;
                        addMessage('error',sprintf($this->language->get('error_restore'),$file));
                    }
                }
                if (!$error && count($xml->files->replaced))
                {
                    addMessage('success',sprintf($this->language->get('success_restore'),trim($xml->title),date('d-m-Y H:i:s',trim($xml->time))));
                }
            }
            else
            {
                $error = true;
                addMessage('error',sprintf($this->language->get('error_file'),basename($filename)));
            }
        }
        else
        {
            $error = true;
            addMessage('error',sprintf($this->language->get('error_file'),basename($filename)));
        }
        $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
    }
    
    public function remove()
    {
        $error = false;
        $filename = DIR_APPLICATION.'../extensions/'.$this->request->get['filename'].'.xml';
        if(file_exists($filename)&&is_file($filename))
        {
            $xmlString = file_get_contents($filename);
            $xml = new SimpleXMLElement($xmlString);
            if ($xml)
            {
                foreach($xml->files->file as $file)
                {
                    if (substr(basename($file),0,6) == 'addist') continue;
                    if (file_exists(DIR_APPLICATION.'../'.$file))
                    {
                        if (!is_writable(DIR_APPLICATION.'../'.$file))
                        {
                            $error = true;
                            addMessage('error',sprintf($this->language->get('error_delete'),$file));
                        }
                    }
                }
                
                if (!$error)
                {
                    foreach($xml->files->file as $file)
                    {
                        if (substr_count($file,'addist') || substr_count($file,'assets')) continue;
                        
                        $file = realpath(DIR_APPLICATION.'../'.$file);
                        if ($file && file_exists($file))
                        {
                            unlink($file);
                        }
                    }
                    foreach($xml->files->file as $file)
                    {
                        if (substr_count($file,'addist') || substr_count($file,'assets')) continue;
                        
                        $file = realpath(DIR_APPLICATION.'../'.$file);
                        if ($file && count(glob(dirname($file).'/*')) == 0)
                        {
                            rmdir(dirname($file));
                        }
                    }
                    unlink($filename);
                }
            }
            else
            {
                $error = true;
                addMessage('error',sprintf($this->language->get('error_file'),basename($filename)));
            }
        }
        else
        {
            $error = true;
            addMessage('error',sprintf($this->language->get('error_file'),basename($filename)));
        }
        
        if (!$error)
        {
            addMessage('success',sprintf($this->language->get('success_removed'),$xml->title,date("Y-m-d H:i:s",trim($xml->time))));
            
        }
        
        $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
    }
    
    function backup()
    {
        $error = false;
        $time = time();
        $filename = DIR_APPLICATION.'../extensions/'.$this->request->get['filename'].'.xml';
        if(file_exists($filename)&&is_file($filename))
        {
            $xmlString = file_get_contents($filename);
            $xml = new SimpleXMLElement($xmlString);
            if ($xml)
            {
                foreach ($xml->files->file as $file)
                {
                    $folder = DIR_APPLICATION.'../extensions/temp/'.$time.'/'.dirname($file);
                    if (!file_exists($folder)||!is_dir($folder))
                    {
                        mkdir($folder,0777,true);
                    }
                    
                    if (file_exists($folder)&&is_dir($folder))
                    {
                        copy(DIR_APPLICATION.'../'.$file,$folder.'/'.basename($file));
                    }
                    else
                    {
                        $error = true;
                        addMessage('error',sprintf($this->language->get('addist_error_chmod'),'extensions/temp/'.$time.'/'.dirname($file)));
                    }
                }
                
                $this->zipFolder(DIR_APPLICATION.'../extensions/temp/'.$time.'/',DIR_APPLICATION.'../extensions/backup/'.$time.'.zip');
                
                $this->rmDir(DIR_APPLICATION.'../extensions/temp/'.$time);
                
                addMessage('success',sprintf($this->language->get('success_backed_up'),$xml->title));
            }
            else
            {
                $error = true;
                addMessage('error',$this->language->get('error_xml_extension'));
            }
        }
        if (!$error)
        {
            $this->redirect($this->url->link('module/ext_manager', 'download='.$time.'&token=' . $this->session->data['token'], 'SSL'));
        }
        else
        {
            $this->redirect($this->url->link('module/ext_manager', 'token=' . $this->session->data['token'], 'SSL'));
        }
    }
    
    public function checkInstall($xml)
    {
        $installed = 3;
        foreach($xml->files->file as $file)
        {
            if (substr(basename($file),0,6) == 'addist') continue;
            if (file_exists(DIR_APPLICATION.'../'.$file))
            {
                $installed = 2;
            }
            if (!file_exists(DIR_APPLICATION.'../'.$file) && $installed)
            {
                $installed = 1;
            }
        }
        return $installed;
    }
    
    function zipFolder($source, $destination)
    {
        if (!extension_loaded('zip') || !file_exists($source)) {
            return false;
        }
        
        $zip = new ZipArchive();
        if (!$zip->open($destination, ZIPARCHIVE::CREATE)) {
            return false;
        }
        
        $source = str_replace('\\', '/', realpath($source));
        
        chdir($source);
        
        if (is_dir($source) === true)
        {
            $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($source), RecursiveIteratorIterator::SELF_FIRST);
    
            foreach ($files as $file)
            {
                $file = str_replace('\\', '/', $file);
    
                // Ignore "." and ".." folders
                if (in_array(substr($file, strrpos($file, '/')+1), array('.', '..')))
                {
                    continue;
                }
                
                $file = str_replace('\\', '/', realpath($file));
                
                if (is_dir($file) === true)
                {
                    $zip->addEmptyDir(str_replace($source . '/', '', $file . '/'));
                }
                else if (is_file($file) === true)
                {
                    $zip->addFromString(str_replace($source . '/', '', $file), file_get_contents($file));
                }
            }
        }
        else if (is_file($source) === true)
        {
            $zip->addFromString(basename($source), file_get_contents($source));
        }
    
        return $zip->close();
    }
    
    public function rmDir($dirPath)
    {
        foreach(new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dirPath, FilesystemIterator::SKIP_DOTS), RecursiveIteratorIterator::CHILD_FIRST) as $path) {
            $path->isDir() ? rmdir($path->getPathname()) : unlink($path->getPathname());
        }
        rmdir($dirPath);
    }
    
    function getExt($name)
    {
        $arr = explode('.',$name);
        return end($arr);
    }
    
    function xml_to_array($xml,$main_heading = '')
    {
        $deXml = simplexml_load_string($xml);
        $deJson = json_encode($deXml);
        $xml_array = json_decode($deJson,TRUE);
        if (! empty($main_heading))
        {
            $returned = $xml_array[$main_heading];
            return $returned;
        }
        else
        {
            return $xml_array;
        }
    }
}
?>