<?php
class ModelFidoPoll extends Model {
	public function getActivePoll() {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "poll WHERE active = '1'");
		return $query->row;
	}

	public function getPollData($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll p LEFT JOIN " . DB_PREFIX . "poll_description pd ON (p.poll_id = pd.poll_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.poll_id = '" . (int)$poll_id . "'");
		return $query->row;
	}

	public function getPollResults($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll_reactions WHERE poll_id = '" . (int)$poll_id . "'");
		return $query->rows;
	}

	public function getTotalResults($poll_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "poll_reactions WHERE poll_id = '" . (int)$poll_id . "'");
		return $query->row['total'];
	}

	public function addReaction($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "poll_reactions SET poll_id = '" . (int)$this->request->post['poll_id'] . "', answer = '" . (int)$this->request->post['poll_answer'] . "'");
	}
}
?>
