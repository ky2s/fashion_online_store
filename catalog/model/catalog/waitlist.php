<?php
class ModelCatalogWaitlist extends Model {

	public function getWaitlistByCustomer($data) {
		
		$customer_id = $this->customer->getId();		

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "waitlist WHERE customer_id = '" . (int)$customer_id . "' AND product_id=". $data['product_id']);

		return $query->row;
	}

	public function addWaitlist($data) 
	{
		$customer_id = $this->customer->getId();	

		$this->db->query("INSERT INTO " . DB_PREFIX . "waitlist SET 
			product_id = '" . (int)$data['product_id'] . "', 
			customer_id = '" . (int)$customer_id . "', 
			status = 1, 
			date_added = NOW()
			");

		return true;
	}

	public function editWaitlistByCustomer($data) {

		$customer_id = $this->customer->getId();
		
		$this->db->query("UPDATE " . DB_PREFIX . "waitlist SET status = '" . $this->db->escape($data['status']) . "'
			WHERE customer_id = '" . (int)$customer_id . "'");
	}
}
