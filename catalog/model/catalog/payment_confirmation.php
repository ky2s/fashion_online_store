<?php
class ModelCatalogPaymentConfirmation extends Model {
    public function getBank(){
        $query = $this->db->query("
             SELECT 
                * 
             FROM 
                " . DB_PREFIX . "extension 
             WHERE 
                `type` = 'payment' 
             AND code LIKE 'trf_%'
        ");

		return $query->rows;
    }
    
    public function confirm(){
        
    }

}