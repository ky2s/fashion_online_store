<?php
class ModelSettingStore extends Model {
	public function getStores($data = array()) {
		$store_data = $this->cache->get('store');

		if (!$store_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "store ORDER BY url");

			$store_data = $query->rows;

			$this->cache->set('store', $store_data);
		}

		return $store_data;
	}

	public function getStoresByField($data = array()) {
		$store_data = "";
		$query_where = "";

		if(!empty($data)){
			//pre('ok');
			$query_where = "WHERE ". $data['field'] ." = ". $data['value'];
		}

		if (!$store_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "store ". $query_where ." ORDER BY url");

			$store_data = $query->rows;

			$this->cache->set('store', $store_data);
		}

		return $store_data;
	}

	public function checkActiveStore($current_url) {

		$return = false;
		
		if ($current_url) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "store WHERE url = '". $current_url ."' AND status = 1 ORDER BY url");

			$data = $query->rows;
			
			$return = (!empty($data)) ? TRUE : FALSE;
		}
		
		return $return;
	}
}