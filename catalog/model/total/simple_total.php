<?php
class ModelTotalSimpleTotal extends Model {
    public function getTotal(&$total_data, &$total, &$taxes) {

        $custom_field_value = $this->config->get('simple_total_custom_value');

        $tmp = $this->config->get('simple_total_custom_id');
        $tmp = explode('.', $tmp);

        $custom_field_set = $tmp[0];
        $custom_field_id = $tmp[1];

        $status = false;

        $checkout_customer = array();
        $checkout_address = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $checkout_customer = isset($this->request->post['checkout_customer']) ? $this->request->post['checkout_customer'] : array();
            $checkout_address = isset($this->request->post['checkout_address']) ? $this->request->post['checkout_address'] : array();
        } else {
            $checkout_customer = isset($this->session->data['simple']['checkout_customer']) ? $this->session->data['simple']['checkout_customer'] : array();
            $checkout_address = isset($this->session->data['simple']['checkout_address']) ? $this->session->data['simple']['checkout_address'] : array();
        }

        if (isset($checkout_customer[$custom_field_id]) && is_array($checkout_customer[$custom_field_id]) && in_array($custom_field_value, $checkout_customer[$custom_field_id])) {
            $status = true;
        } elseif (isset($checkout_address[$custom_field_id]) && is_array($checkout_address[$custom_field_id]) && in_array($custom_field_value, $checkout_address[$custom_field_id])) {
            $status = true;
        } elseif (isset($checkout_customer[$custom_field_id]) && !is_array($checkout_customer[$custom_field_id]) && $custom_field_value == $checkout_customer[$custom_field_id]) {
            $status = true;
        } elseif (isset($checkout_address[$custom_field_id]) && !is_array($checkout_address[$custom_field_id]) && $custom_field_value == $checkout_address[$custom_field_id]) {
            $status = true;
        }

        if ($status) {
            $language_code = str_replace('-', '_', strtolower($this->config->get('config_language')));

            $lang = $this->config->get('simple_total_label');
            $value = $this->config->get('simple_total_value');

            $total_data[] = array( 
                'code'       => 'simple_total',
                'title'      => isset($lang[$language_code]) ? $lang[$language_code] : 'simple_total',
                'text'       => $this->currency->format($value),
                'value'      => $value,
                'sort_order' => $this->config->get('simple_total_sort_order')
            );
            
            $total += $value;
        }
    }
}
?>