<?php
class ModelTotalGiftCard extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if (isset($this->session->data['gift_card_method'])) {
			$this->load->language('total/gift_card');

			$total_data[] = array(
				'code'       => 'gift_card',
				'title'      => $this->language->get('text_handling'),				
				'value'      => $this->session->data['gift_card_method']['card_price'],
				'sort_order' => $this->config->get('gift_card_sort_order')
			);			
			$total += $this->session->data['gift_card_method']['card_price'];
		}
	}
}