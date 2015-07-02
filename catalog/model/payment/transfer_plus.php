<?php 
class ModelPaymentTransferPlus extends Model {
    private $type = 'payment';
   	private $name = 'transfer_plus';

  	public function getMethod($address, $total) {
        $this->language->load($this->type . '/' . $this->name);

        $method_data = array();

        if ($this->config->get($this->name.'_status') == true) {
            $quote_data = array();

            if (is_array($this->config->get($this->name.'_module')) and count($this->config->get($this->name.'_module')) > 0) {
                foreach($this->config->get($this->name.'_module') as $key => $module) {
                    if ($module['status'] == 1) {

                        if (isset($module['store']) and is_array($module['store']) and in_array((int)$this->config->get('config_store_id'), $module['store'])) {

                            $status = true;

                            if (isset($module['geo_zone']) and is_array($module['geo_zone']) and count($module['geo_zone']) > 0 ) {
                                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone
                                    WHERE geo_zone_id IN (" . implode(',', $module['geo_zone']) . ") AND country_id = " . (int)$address['country_id'] . "
                                    AND (zone_id = " . (int)$address['zone_id'] . " OR zone_id = 0)");
                                if ($query->num_rows) {
                                    $status = true;
                                }
                                else {
                                    $status = false;
                                }
                            }

                            $module['min_total'] = (int)$module['min_total'];
                            $module['max_total'] = (int)$module['max_total'];

                            if ($status == true and
                                    (
                                        ($module['min_total'] > 0 and $module['max_total'] > 0 and $total >= $module['min_total'] and $total < $module['max_total']) or
                                        ($module['min_total'] > 0 and $module['max_total'] == 0 and $total >= $module['min_total']) or
                                        ($module['max_total'] > 0 and $module['min_total'] == 0 and $total < $module['max_total']) or
                                        ($module['max_total'] == 0 and $module['min_total'] == 0)
                                    )
                                )
                            {

                                $quote_data[$key] = array(
                                    'code'            => $this->name.'.'.$key,
                                    'title'           => $module['title'][$this->config->get('config_language_id')],
                                    'image'           => $module['image'],
                                    'sort_order'      => $module['sort_order'],
                                    'description'     => ''
                                );
                            }
                        }
                    }
                }
            }


            if (isset($quote_data) and count($quote_data) > 0) {
                $sort_by = array();
                foreach ($quote_data as $key => $value) $sort_by[$key] = $value['sort_order'];
                array_multisort($sort_by, SORT_ASC, $quote_data);

                $method_data = array(
                    'code'       => $this->name,
                    'quote'      => $quote_data,
                    'sort_order' => $this->config->get($this->name.'_sort_order')
                );
            }
        }

    	return $method_data;
  	}
}
?>