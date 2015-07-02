<?php
class ModelModuleAlternative extends Model {
	
	//Получение данных о товаре
	public function getProduct($product_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$sql = "SELECT DISTINCT * ";
		$sql .= ", pd.name AS name ";
		$sql .= ", p.image ";
		$sql .= ", (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special ";
		$sql .= ", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating ";
		$sql .= ", (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews ";
		
		$sql .= "FROM " . DB_PREFIX . "product p ";
		$sql .= "LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) ";
		$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) ";
		$sql .= "LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) ";
		
		$sql .= "WHERE p.product_id = '" . (int)$product_id . "' ";
		$sql .= "AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ";
		$sql .= "AND p.status = '1' ";
		$sql .= "AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
		
		$query = $this->db->query($sql);

		if ($query->num_rows) {
			return array(
				'product_id'       => $query->row['product_id'],
				'name'             => $query->row['name'],
				'image'            => $query->row['image'],
				'price'            => $query->row['price'],
				'special'          => ($query->row['special']) ? $query->row['special'] : 0,
				'tax_class_id'     => $query->row['tax_class_id'],
				'manufacturer_id'  => $query->row['manufacturer_id'],
				'rating'           => round($query->row['rating']),
				'reviews'          => $query->row['reviews'] ? $query->row['reviews'] : 0
			);
		} else {
			return false;
		}
	}
	
	//Получение списка альтернативных товаров
	public function getAlternativeProducts($product_id, $category_id, $this_price, $this_manufacture, $type_id, $attribute_id, $manufacture) {	
		$product_data = array();
		$access = true;
		
		if ($type_id == 1) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute  WHERE product_id = '" . $product_id . "' AND attribute_id = '" . $attribute_id . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
			
			if ($query->num_rows == 0) {	
				$access = false;
			}
		}
		
		if ($access) {
		
			$sql = "SELECT p.product_id AS product_id ";
			$sql .= ", (ABS(p.price-".$this_price.")) AS new_price ";
			$sql .= ", (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "order_product op WHERE op.product_id = p.product_id) AS orders ";
			$sql .= ", p.viewed AS viewed ";
			$sql .= ", (SELECT ROUND(IFNULL(AVG(r1.rating), 0)) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1') AS rating ";
			$sql .= ", (SELECT COUNT(r2.review_id) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1') AS reviews ";
			$sql .= ", (p.manufacturer_id=".$this_manufacture.") AS manufacture ";
			$sql .= ", p.date_added AS date_added ";
			
			$sql .= "FROM " . DB_PREFIX . "product p ";
			$sql .= "LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) ";
			$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) ";
			if ($type_id == 0) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id = p.product_id) ";
			}
			if ($type_id == 1) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "product_attribute pa ON (p.product_id = pa.product_id) ";
			}
			
			$sql .= "WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ";
			$sql .= "AND p.status = '1' AND p.quantity > 0 ";
			$sql .= "AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ";
			if ($type_id == 0) {
			$sql .= "AND p2c.category_id = '" . $category_id . "' ";
			}
			if ($type_id == 1) {
			$text = $query->row['text'];
			$sql .= "AND pa.attribute_id = '" . $attribute_id . "' ";
			$sql .= "AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "' ";
			$sql .= "AND pa.text = '" . $text . "' ";
			if ($manufacture) {
			$sql .= "AND p.manufacturer_id=".$this_manufacture." ";
			}
			}
			
			$sql .= "ORDER BY new_price ASC, orders DESC, viewed DESC, rating DESC, reviews DESC, manufacture DESC, date_added DESC";

			$query = $this->db->query($sql);
			
			foreach ($query->rows as $result) {
				$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
			}
		}

		return $product_data;
	}
	
	//Получение Id первой категории в базе данных для текущего товара
	public function getProductCategoryId($product_id) {
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id='".(int)$product_id."' LIMIT 1");
		
		return (int)$query->row['category_id'];
	}
	
	//Получение Id первого товара в базе данных
	public function getProductId() {
		$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product LIMIT 1");
		
		return (int)$query->row['product_id'];
	}
	
}
?>