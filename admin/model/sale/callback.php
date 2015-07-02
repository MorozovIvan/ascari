<?php
class ModelSaleCallback extends Model {

	public function editCallback($callback_id,$data) {
      	$this->db->query("UPDATE " . DB_PREFIX . "callback SET comment = '" . $this->db->escape($data['comment']) . "', username = '" . $this->db->escape($data['username']) . "', status_id = '" . (int)$data['status_id'] . "', date_modified = NOW() WHERE call_id = '" . (int)$callback_id . "'");	
	}

	
	public function editCallbacks($callback_id) {
      	$this->db->query("UPDATE " . DB_PREFIX . "callback SET status_id = '1', date_modified = NOW() WHERE call_id = '" . (int)$callback_id . "'");


	}
	
	public function deleteCallback($callback_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "callback WHERE call_id = '" . (int)$callback_id . "'");

			
		$this->cache->delete('callback');
	}	
	
	public function getСallback($callback_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "callback WHERE call_id = '" . (int)$callback_id . "'");
		
		return $query->row;
	}
	
	public function getCallbacks($data = array()) {

		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "callback";
			
			$sort_data = array(
				'call_id',
				'name',
				'telephone',
				'username',
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY call_id";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}					

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}				
			
			$query = $this->db->query($sql);
		
			return $query->rows;
		} else {
			$callback_data = $this->cache->get('callback');
		
			if (!$callback_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "callback ORDER BY call_id");
	
				$callback_data = $query->rows;
			
				$this->cache->set('callback', $callback_data);
			}
		 
			return $callback_data;
		}
	}
	


	public function getTotalCallbacks() {
$query = $this->db->query("CREATE TABLE IF NOT EXISTS  " . DB_PREFIX . "callback (call_id int(11) NOT NULL primary key AUTO_INCREMENT,name varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,telephone varchar(30) NOT NULL,date_added datetime NOT NULL,date_modified datetime NOT NULL,status_id int(11) NOT NULL,comment text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,comment_buyer text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, email_buyer text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, username text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL, user_id text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL)");

      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "callback"); 
		
		return $query->row['total'];
	}	
}
?>
