<?php
class ModelToolTruncate extends Model {
    public function order(){
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_custom_field`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_fraud`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_history`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_option`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_product`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_recurring`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_recurring_transaction`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_shipping`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_status_vendor_update`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_total`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "order_voucher`");
        
        $this->db->query("TRUNCATE `" . DB_PREFIX . "recurring`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "recurring_description`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "return`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "return_history`");
    }
    
    public function coupon(){
        $this->db->query("TRUNCATE `" . DB_PREFIX . "coupon`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_category`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_history`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_product`");
    }
    
    public function customer(){
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_activity`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_authentication`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_ban_ip`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_history`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_ip`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_login`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_online`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_reward`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_transaction`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "address`");
        $this->db->query("TRUNCATE `" . DB_PREFIX . "newsletter`");
    }
}