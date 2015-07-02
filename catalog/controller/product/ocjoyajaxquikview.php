<?php
	error_reporting(0);
class ControllerProductOcjoyajaxquikview extends Controller {
    
    public function index() {
        $this->data += $this->load->language('product/ocjoyajaxquikview');
        $this->data += $this->config->get('config_ocjoyajaxquikview_form');
        $ocjoyajaxquikview_alltext = $this->load->language('product/ocjoyajaxquikview');
        $ocjoyajaxquikview_form = $this->config->get('config_ocjoyajaxquikview_form');

        $this->load->model('catalog/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        }
        $oc_version = explode('.', VERSION);
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        $this->data['product_id'] = $product_id;
        $this->data['href'] = $this->url->link('product/product', 'product_id=' . $product_id);
        $this->data['product_info'] = $product_info;

        $this->data['heading_title'] = $product_info['name'];
        $this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
        $this->data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);
        
        $this->load->model('catalog/review');

        $this->data['manufacturer'] = $product_info['manufacturer'];
        $this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
        $this->data['model'] = $product_info['model'];
        $this->data['reward'] = $product_info['reward'];
        $this->data['points'] = $product_info['points'];
        $this->data['weight_show'] = $product_info['weight'];
        $this->data['weight'] = $this->weight->format($product_info['weight'], $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));

        if ($product_info['quantity'] <= 0) {
            $this->data['stock'] = $product_info['stock_status'];
        } elseif ($this->config->get('config_stock_display')) {
            $this->data['stock'] = $product_info['quantity'];
        } else {
            $this->data['stock'] = $this->language->get('text_instock');
        }
        
        $this->load->model('tool/image');

        $main_width = (!empty($ocjoyajaxquikview_form['main_width'])) ? $ocjoyajaxquikview_form['main_width'] : "228";
        $main_height = (!empty($ocjoyajaxquikview_form['main_height'])) ? $ocjoyajaxquikview_form['main_height'] : "228";
        $sub_width = (!empty($ocjoyajaxquikview_form['sub_width'])) ? $ocjoyajaxquikview_form['sub_width'] : "74";
        $sub_height = (!empty($ocjoyajaxquikview_form['sub_height'])) ? $ocjoyajaxquikview_form['sub_height'] : "74";
        $main_popup_width = (!empty($ocjoyajaxquikview_form['main_popup_width'])) ? $ocjoyajaxquikview_form['main_popup_width'] : "500";
        $main_popup_height = (!empty($ocjoyajaxquikview_form['main_popup_height'])) ? $ocjoyajaxquikview_form['main_popup_height'] : "500";

        if ($product_info['image']) {
            $this->data['thumb'] = $this->model_tool_image->resize($product_info['image'], $main_width,  $main_height);
            $this->data['popup'] = $this->model_tool_image->resize($product_info['image'], $main_popup_width,  $main_popup_height);
        } else {
            $this->data['thumb'] = $this->model_tool_image->resize("no_image.jpg", $main_width,  $main_height);
            $this->data['popup'] = $this->model_tool_image->resize("no_image.jpg", $main_popup_width,  $main_popup_height);
        }
        
        $this->data['images'] = array();
        $results = $this->model_catalog_product->getProductImages($product_id);
        
        foreach ($results as $result) {
            $this->data['images'][] = array(
                'product_image_id' => $result['product_image_id'],
                'popup' => $this->model_tool_image->resize($result['image'], $main_popup_width,  $main_popup_height),
                'thumb' => $this->model_tool_image->resize($result['image'], $sub_width, $sub_height),
                'thumb2' => $this->model_tool_image->resize($result['image'], $main_width, $main_height)
            );
        }   
                    
        $this->data['price'] = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'))) : false;
        $this->data['special'] = ((float)$product_info['special']) ? $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'))) : false;
        $this->data['tax'] = ($this->config->get('config_tax')) ? $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']) : false;
        
        $discounts = $this->model_catalog_product->getProductDiscounts($product_id);
        $this->data['discounts'] = array(); 
        
        foreach ($discounts as $discount) {
            $this->data['discounts'][] = array(
                'quantity' => $discount['quantity'],
                'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
            );
        }
        
        $this->data['options'] = array();
        
        foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) { 
            if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
                $option_value_data = array();
                foreach ($option['option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $price = false;
                        }
                        
                        $option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id'         => $option_value['option_value_id'],
                            'name'                    => $option_value['name'],
                            'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'price'                   => $price,
                            'price_prefix'            => $option_value['price_prefix']
                        );
                    }
                }
                
                $this->data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'option_id'         => $option['option_id'],
                    'name'              => $option['name'],
                    'type'              => $option['type'],
                    'option_value'      => $option_value_data,
                    'required'          => $option['required']
                );                  
            } elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
                $this->data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'option_id'         => $option['option_id'],
                    'name'              => $option['name'],
                    'type'              => $option['type'],
                    'option_value'      => $option['option_value'],
                    'required'          => $option['required']
                );                      
            }
        }
                        
        $this->data['minimum'] = ($product_info['minimum']) ? $product_info['minimum'] : 1;    
        $this->data['review_status'] = $this->config->get('config_review_status');
        $this->data['reviews'] = sprintf($this->language->get('text_reviews'), $product_info['reviews']);
        $this->data['rating'] = (int)$product_info['rating'];
        $this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
        $this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($product_id);
        
        $this->data['products'] = array();
        $results = $this->model_catalog_product->getProductRelated($product_id);
        
        foreach ($results as $result) {
            $image = ($result['image']) ? $this->model_tool_image->resize($result['image'], 80, 80) : $this->model_tool_image->resize("no_image.jpg", 80, 80);
            $price = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;  
            $special = ((float)$result['special']) ? $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;
            $rating = ($this->config->get('config_review_status')) ? (int)$result['rating'] : false;
                
            $this->data['products'][] = array(
                'product_id'  => $result['product_id'],
                'thumb'       => $image,
                'name'        => $result['name'],
                'price'       => $price,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '...',
                'special'     => $special,
                'rating'      => $rating,
                'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
            );
        }   
        
        $this->data['tags'] = array();
        
        if ($oc_version[2] >= "4") {
            if ($product_info['tag']) {     
                $tags = explode(',', $product_info['tag']);
                foreach ($tags as $tag) {
                    $this->data['tags'][] = array(
                        'tag'  => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }
        } else {
            $results = $this->model_catalog_product->getProductTags($product_id);
            foreach ($results as $result) {
                $this->data['tags'][] = array(
                    'tag'  => $result['tag'],
                    'href' => $this->url->link('product/search', 'filter_tag=' . $result['tag'])
                );
            }
        }

        $this->model_catalog_product->updateViewed($product_id);
        
        $this->language->load('product/product');
     
        $this->load->model('catalog/review');

        $this->data['text_on'] = $this->language->get('text_on');
        $this->data['text_no_reviews'] = $this->language->get('text_no_reviews');
        $page = (isset($this->request->get['page'])) ? $this->request->get['page'] : 1;
        
        $this->data['reviews2'] = array();
        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($product_id);
            
        $results = $this->model_catalog_review->getReviewsByProductId($product_id, ($page - 1) * 5, 5);
            
        foreach ($results as $result) {
            $this->data['reviews2'][] = array(
                'author'     => $result['author'],
                'text'       => $result['text'],
                'rating'     => (int)$result['rating'],
                'reviews'    => sprintf($this->language->get('text_reviews'), (int)$review_total),
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }           
            
        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = 5; 
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('product/ocjoyajaxquikview/review', 'product_id=' . $product_id . '&page={page}');
        $this->data['pagination'] = $pagination->render();
        
        $this->template = (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/ocjoyajaxquikview.tpl')) ? $this->config->get('config_template') . '/template/product/ocjoyajaxquikview.tpl' : 'default/template/product/ocjoyajaxquikview.tpl';

        $this->response->setOutput($this->render());
    }

    public function write() {
        $this->language->load('product/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        }
       
        $this->load->model('catalog/review');
        
        $json = array();
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }
            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }
            if (empty($this->request->post['rating'])) {
                $json['error'] = $this->language->get('error_rating');
            }
            if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
                $json['error'] = $this->language->get('error_captcha');
            } 
            if (!isset($json['error'])) {
                $this->model_catalog_review->addReview($product_id, $this->request->post);
                $json['success'] = $this->language->get('text_success');
            }
        }
        $this->response->setOutput(json_encode($json));
    }
   
    public function captcha() {
        $this->load->library('captcha');
        $captcha = new Captcha();
        $this->session->data['captcha'] = $captcha->getCode();
        $captcha->showImage();
    }
}
?>