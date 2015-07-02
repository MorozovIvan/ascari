<?php
class ModelModuleCallback extends Model {	
	public function addCallback($data) {

    	  	$query = $this->db->query("INSERT INTO " . DB_PREFIX . "callback SET name = '" . $data['name']  . "', comment_buyer = '" . $data['comment_buyer']  . "',email_buyer = '" . $data['email_buyer']  . "', telephone = '" . $data['phone'] . "', date_added = NOW(), date_modified = NOW(), status_id = '0', comment = ''");
	
		return $this->db->getLastId();;
	}	
		
}
?>
