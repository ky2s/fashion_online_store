<?php
class ModelCatalogManufacturer extends Model {
	public function getManufacturer($manufacturer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) WHERE m.manufacturer_id = '" . (int)$manufacturer_id . "' AND m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

		return $query->row;
	}

	public function getManufacturers($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

			$sort_data = array(
				'name',
				'sort_order'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY name";
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
			$manufacturer_data = $this->cache->get('manufacturer.' . (int)$this->config->get('config_store_id'));

			if (!$manufacturer_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY name");

				$manufacturer_data = $query->rows;

				$this->cache->set('manufacturer.' . (int)$this->config->get('config_store_id'), $manufacturer_data);
			}

			return $manufacturer_data;
		}
	}

	public function getManufacturersWithCount($categoryID) {
		if ($categoryID == 0)  {
			$sql = "SELECT m.manufacturer_id, m.name, COUNT(p.manufacturer_id) AS 'c' FROM " . DB_PREFIX . "manufacturer m 
		        LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s 
		        ON (m.manufacturer_id = m2s.manufacturer_id) 
				LEFT JOIN " . DB_PREFIX . "product p
				ON (p.manufacturer_id = m.manufacturer_id) 
				LEFT JOIN " . DB_PREFIX . "product_to_category pc					
				ON (p.product_id = pc.product_id)						
		        WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'			        
		        GROUP BY m.manufacturer_id 
		        ORDER BY name";
		} else {
			$sql = "SELECT m.manufacturer_id, m.name, COUNT(p.manufacturer_id) AS 'c' FROM " . DB_PREFIX . "manufacturer m 
		        LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s 
		        ON (m.manufacturer_id = m2s.manufacturer_id) 
				LEFT JOIN " . DB_PREFIX . "product p
				ON (p.manufacturer_id = m.manufacturer_id) 
				LEFT JOIN " . DB_PREFIX . "product_to_category pc					
				ON (p.product_id = pc.product_id)						
		        WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
		        AND pc.category_id = '".(int)$categoryID."'
		        GROUP BY m.manufacturer_id 
		        ORDER BY name";
		}
			
		$query = $this->db->query($sql);
		$manufacturer_data = $query->rows;
		$this->cache->set('manufacturer.' . (int)$this->config->get('config_store_id'), $manufacturer_data);
	
		return $manufacturer_data;
	}
}