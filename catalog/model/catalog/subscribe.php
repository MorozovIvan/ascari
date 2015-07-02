<?php
class ModelCatalogSubscribe extends Model {
	public function addCustomer($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET store_id = '" . (int) $this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', email = '" . $this->db->escape($data['email']) . "', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', newsletter='1', status = '1', approved = '". (int) $data['approved'] ."', date_added = NOW()");

		$customer_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "'");

		$address_id = $this->db->getLastId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
	}

	public function checkCustomers() {
		$query = $this->db->query("SELECT customer_id, email, approved FROM " . DB_PREFIX . "customer");

		return $query->rows;
	}

	public function approvedCustomer($customer_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET approved ='1' WHERE customer_id = '" . (int)$customer_id . "'");
	}
}
?>
