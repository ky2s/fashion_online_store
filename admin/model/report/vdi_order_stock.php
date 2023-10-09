<?php
class ModelReportVDIOrderStock extends Model {
	public function getOrderAndStock() {
	$query = $this->db->query("SELECT a.key, a.product_id, a.quantity, a.name, a.order_id, a.date_added FROM ((SELECT CONCAT('new_order_product') AS `key`, op.product_id, p.quantity, pd.name, op.order_id, o.date_added FROM `" . DB_PREFIX . "order_product` op LEFT JOIN `" . DB_PREFIX . "order` o ON (op.order_id = o.order_id) LEFT JOIN `" . DB_PREFIX . "product` p ON (op.product_id = p.product_id) LEFT JOIN `" . DB_PREFIX . "product_description` pd ON (op.product_id = pd.product_id) LEFT JOIN `" . DB_PREFIX . "vendor` v ON (op.product_id = v.vproduct_id) WHERE op.vendor_id = '" . (int)$this->user->getVP() . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') UNION (SELECT CONCAT('low_stock_product') AS `key`, p.product_id, p.quantity, pd.name, CONCAT('') AS `order_id`, IFNULL(o.date_added,NOW()) as data_added FROM `" . DB_PREFIX . "product` p LEFT JOIN `" . DB_PREFIX . "product_description` pd ON (p.product_id = pd.product_id) LEFT JOIN `" . DB_PREFIX . "order_product` op ON (p.product_id = op.product_id) LEFT JOIN `" . DB_PREFIX . "order` o ON (op.order_id = o.order_id) LEFT JOIN `" . DB_PREFIX . "vendor` v ON (p.product_id = v.vproduct_id) WHERE v.vendor = '" . (int)$this->user->getVP() . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.quantity <= '" . (int)$this->config->get('mvd_stock_threshold') . "' GROUP BY p.product_id)) a ORDER BY a.date_added DESC LIMIT 0,5");
	
	return $query->rows;
	}
}