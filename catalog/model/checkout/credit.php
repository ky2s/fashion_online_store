<?php
class ModelCheckoutCredit extends Model {
	public function getCredit($custId)
	{
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_transaction WHERE customer_id = '" . $custId . "'";

		return $this->db->query($sql)->rows;
	}
}