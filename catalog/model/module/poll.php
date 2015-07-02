<?php
class ModelModulePoll extends Model {
	
	public function getPollName()
	{
		$poll_data = $this->cache->get('poll.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));

		if (!$poll_data) { 
			$query = $this->db->query("SELECT name, id FROM " . DB_PREFIX . "poll WHERE active = 1 LIMIT 1");
			$poll_data = $query->row;
			$this->cache->set('poll.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $poll_data);
		}
		return $poll_data;
	}
	
	public function getPollResponses($poll_id)
	{
		$poll_data = $this->cache->get('poll_response.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $poll_id);

		if (!$poll_data) { 
			$query = $this->db->query("SELECT name,count,id FROM " . DB_PREFIX . "poll_response WHERE poll_id = " . $poll_id);
			$poll_data = $query->rows;
			$this->cache->set('poll_response.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $poll_id, $poll_data);
		}
		return $poll_data;
	}
	
	
	public function answerPoll($id)
	{
		$query = $this->db->query("UPDATE " . DB_PREFIX . "poll_response SET count=(count+1) WHERE id = " . $id);
		$this->cache->delete('poll_response');
	}
	
	public function pollResults($voted=false)
	{
		$poll_info = $this->getPollName();
		$name = $poll_info['name'];
		$responses = $this->getPollResponses($poll_info['id']);
		
		$total_count = 0;
		foreach ($responses as $response) {
			$total_count += $response['count'];
		}
		
		
		$output = '<h5 id="pollResultsName">' . $name . '</h5>';
		if ($voted) {
			$output .= '<div class="warning">Вы уже голосовали!</div>';
		}
		
		foreach ($responses as $response) {
	  		$percentage = ($total_count > 0) ? sprintf("%.2f", $response['count'] / $total_count * 100) : "0.00";
		    $output .= $response['name'];
		    $output .= '<div class="holder">';
		    $output .= '<div class="emptyPoll"></div>';
		    $output .= '<div class="fullPoll" style="width:' . round($percentage) . '%"></div>';
		    $output .= '</div>';
		    $output .= '<span class="votes">Всего проголосовало - ' . $response['count'] . '</span><br />';
		}
		
		$output .= '<p class="pollBack" style="text-align:center;"><a class="pollButton" id="showButton" href="javascript:window.location.reload();">Назад</a></p>';
		return $output;
	}
	
}

?>