<?php   
class ControllerCommonAmenu extends Controller {
	protected function index() {
		// Menu
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if ($this->config->get('config_menu_brands')) {
			$data = array();
				$this->load->model('catalog/manufacturer');
				$this->data['manufacturer'] = array();
				$manufacturers = $this->model_catalog_manufacturer->getManufacturers($data);
				if($manufacturers){
				foreach($manufacturers as $manufacturer){
					$this->data['manufacturer'][] = array(
					'name' => $manufacturer['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id='.$manufacturer['manufacturer_id'])
					);
				}
			}
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['text_benefits'] = $this->language->get('text_benefits');

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);
				$category_info = $this->model_catalog_category->getCategory($category['category_id']);

				$data = array(
					'filter_category_id'  => $category['category_id'],
					'filter_sub_category' => true
				);

				$data = array(
					'filter_category_id' => $category['category_id'],
					'filter_sub_category' => true,
					'order'              => 'ASC',
					'start'              => 0,
					'limit'              => 6
				);

				$product_total_root = $this->model_catalog_product->getProducts($data);

				foreach ($children as $child) {
					if ($this->config->get('config_product_count')) {
						//var_dump($child);
						$data = array(
							'filter_category_id'  => $child['category_id'],
							'filter_sub_category' => true
						);
						$product_total = $this->model_catalog_product->getTotalProducts($data);

					}

					//Level 3
		        $subchildren = $this->model_catalog_category->getCategories($child['category_id']);
				    $subchildren_data = array(); 
				foreach ($subchildren as $subchild) {
					if ($this->config->get('config_product_count')) {
						$data = array(
							  'filter_category_id'  => $subchild['category_id'],
							  'filter_sub_category' => true
						);
 
						$sub_total = $this->model_catalog_product->getTotalProducts($data);
					}

					$subchildren_data[] = array(
								'name'  => $subchild['name'] . ($this->config->get('config_product_count') ? ' (' . $sub_total . ')' : ''),
								'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']. '_' . $subchild['category_id'])	
						);						
					}								
 
					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),					
						'subchildren' => $subchildren_data,
 
					);						
				}				
					//Level	3

				$cat_info = array(
					'name' => html_entity_decode($category_info['seo_h1'], ENT_QUOTES, 'UTF-8'),
					'description' => html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8'),
					'description_bottom' => html_entity_decode($category_info['description_bottom'], ENT_QUOTES, 'UTF-8'),
				);

				$product_total_arr = array();

				foreach ($product_total_root as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						$imagewidth = $this->config->get('config_image_product_width');
						$imageheight = $this->config->get('config_image_product_height');
					} else {
						$image = 'catalog/view/theme/default/image/grey.gif';
						$imagewidth = '';
						$imageheight = '';
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}

					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}

					$stickers = $this->getStickers($result['product_id']) ;
					//ocshop benefits
					$productbenefits = $this->model_catalog_product->getProductBenefitsbyProductId($result['product_id']);

					$benefits = array();

					$url = '';

					foreach ($productbenefits as $benefit) {
						if ($benefit['image'] && file_exists(DIR_IMAGE . $benefit['image'])) {
							$bimage = $benefit['image'];
							if ($benefit['type']) {
								$bimage = $this->model_tool_image->resize($bimage, 25, 25);
							} else {
								$bimage = $this->model_tool_image->resize($bimage, 120, 60);
							}
						} else {
							$bimage = 'no_image.jpg';
						}

						$benefits[] = array(
							'benefit_id'      	=> $benefit['benefit_id'],
							'name'      		=> $benefit['name'],
							'description'      	=> strip_tags(html_entity_decode($benefit['description'])),
							'thumb'      		=> $bimage,
							'link'      		=> $benefit['link'],
							'type'      		=> $benefit['type']
							//'sort_order' => $benefit['sort_order']
						);
					}

					//ocshop benefits
					$product_total_arr[] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'thumbwidth'  => $imagewidth,
						'thumbheight' => $imageheight,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
						'description_mini' => html_entity_decode ($result['description_mini']),
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $result['rating'],
						'sticker'     => $stickers,
						'benefits'    => $benefits,
						'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
						'href'        => $this->url->link('product/product', 'path=' . '' . '&product_id=' . $result['product_id'] . $url)
					);
				}

//var_dump($products_info);
				// Level 1
				//var_dump($products_info);
				$this->data['categories'][] = array(
					'name'     => $category['name'],
					'info'     => $cat_info,
					'products' => $product_total_arr,
					'children' => $children_data,
					'active'   => in_array($category['category_id'], $parts),
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/amenu.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/amenu.tpl';
		} else {
			$this->template = 'default/template/common/amenu.tpl';
		}

		$this->render();
	}

	private function getStickers($product_id) {

		$stickers = $this->model_catalog_product->getProductStickerbyProductId($product_id) ;

		if (!$stickers) {
			return;
		}

		$this->data['stickers'] = array();

		foreach ($stickers as $sticker) {
			$this->data['stickers'][] = array(
				'position' => $sticker['position'],
				'image'    => HTTP_SERVER . 'image/' . $sticker['image']
			);
		}


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/stickers.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/stickers.tpl';
		} else {
			$this->template = 'default/template/product/stickers.tpl';
		}

		return $this->render();

	}
}
?>