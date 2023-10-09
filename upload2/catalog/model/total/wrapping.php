<?php
class ModelTotalWrapping extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if (isset($this->session->data['wrap_method'])) {
			$this->load->language('total/wrapping');

			$total_data[] = array(
				'code'       => 'wrapping',
				'title'      => $this->language->get('text_handling'),				
				'value'      => $this->session->data['wrap_method']['wrap_price'],
				'sort_order' => $this->config->get('wrapping_sort_order')
			);			
			$total += $this->session->data['wrap_method']['wrap_price'];
		}
	}
}