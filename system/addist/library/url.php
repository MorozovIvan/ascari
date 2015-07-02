<?php
class AddistUrl
{
	private $domain;
	private $ssl;

	public function __construct($domain, $ssl = '')
    {
		$this->domain = $domain;
		$this->ssl = $ssl;
	}

	public function link($route, $args = '', $secure = false, $no_store = false)
    {
		if (!$secure)
        {
			$url = $this->domain;
		}
        else
        {
			$url = $this->ssl;
		}

		$url .= 'index.php?route=' . $route;
        
        $args = preg_replace('#&store_id\=(\d+)#','',$args);
        
        if (!$no_store && IS_ADMIN && STORE_ID && !substr_count($args,'store_id='))
        {
            $args .=  '&store_id='.STORE_ID;
        }
        
		if ($args) {
			$url .= str_replace('&', '&amp;', '&' . ltrim($args, '&'));
		}
        
		return $url;
	}
}
?>