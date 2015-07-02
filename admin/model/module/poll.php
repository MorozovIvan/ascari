<?php
class ModelModulePoll extends Model {
	
	public function createModuleTables() {
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "poll (id INT(11) AUTO_INCREMENT, name VARCHAR(255), active BOOLEAN, date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id))");
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "poll_response (id INT(11) AUTO_INCREMENT, poll_id INT(11), name VARCHAR(255), count INT DEFAULT '0', date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id))");
	}	
	
	public function addPoll($data) 
	{
		if ($data['active'] == 1) {
			$query = $this->db->query("UPDATE " . DB_PREFIX . "poll SET active = 0");
		}
		$query = $this->db->query("INSERT INTO " . DB_PREFIX . "poll SET name = '" . $this->db->escape($data['name']) . "', active = " . $this->db->escape($data['active']));
		$poll_id = $this->db->getLastId();
		
		foreach ($data['responses'] as $response) {
			if ($response != '') {
				$this->addResponse($poll_id, $response);
			}
		}
		$this->cache->delete('poll_response');
		$this->cache->delete('poll');
	}
	
	public function editPoll($poll_id, $data) 
	{
		if ($data['poll_active'] == 1) {
			$query = $this->db->query("UPDATE " . DB_PREFIX . "poll SET active = 0");
		} else {
			$data['poll_active'] = 0;
		}
		$query = $this->db->query("UPDATE " . DB_PREFIX . "poll SET name = '" . $this->db->escape($data['poll_name']) . "', active = " . (int) $data['poll_active'] . ' WHERE id = ' . (int)$poll_id);
		$poll_id = $this->db->getLastId();
		
		$query = $this->db->query("DELETE FROM " . DB_PREFIX . "poll_response WHERE poll_id = " . (int)$poll_id);
		foreach ($data['poll_response'] as $response) {
			if ($response != '') {
				$this->addResponse($poll_id, $response);
			}
		}
		$this->cache->delete('poll_response');
		$this->cache->delete('poll');
	}
	
	private function addResponse($poll_id, $name) 
	{
		$query = $this->db->query("INSERT INTO " . DB_PREFIX . "poll_response SET name = '" . $this->db->escape($name) . "', poll_id = " . $poll_id);
	}
	
	public function getPolls() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll");
		return $query->rows;
	}
	
	public function getPoll($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll WHERE id = " . (int)$poll_id);
		return $query->row;
	}
	
	public function getResponses($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll_response WHERE poll_id = " . (int)$poll_id);
		return $query->rows;
	}
	
	public function deletePoll($poll_id) {
		$query = $this->db->query("DELETE FROM " . DB_PREFIX . "poll WHERE id = " . (int)$poll_id);
		$query = $this->db->query("DELETE FROM " . DB_PREFIX . "poll_response WHERE poll_id = " . (int)$poll_id);
		$this->cache->delete('poll_response');
		$this->cache->delete('poll');
	}
}
?>