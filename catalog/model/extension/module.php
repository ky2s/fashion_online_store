<?php
class ModelExtensionModule extends Model {
	public function getModule($module_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE module_id = '" . (int)$module_id . "'");
		
		if ($query->row) {
			return unserialize($query->row['setting']);
		} else {
			return array();	
		}
	}		

	public function getFeatured($store_id=0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE code = 'featured' AND store_id = '" . (int)$store_id . "'");
		
		if ($query->row) {
			return unserialize($query->row['setting']);
		} else {
			return array();	
		}
	}
}