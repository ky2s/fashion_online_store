<?php
class ModelToolCron extends Model {
	public function updatePending() {
		$this->load->model('checkout/order');
		
		$this->db->query("
			INSERT INTO 
				" . DB_PREFIX . "order_history 
				(
					order_history_id,
					order_id,
					order_status_id,
					notify,
					comment,
					date_added,
					vendor_id,
					added_by
				)
				SELECT
					'',
					order_id,
					20,
					'',
					'Failed by System',
					NOW(),
					'',
					1
				FROM
					(
						SELECT
							DATEDIFF(CURDATE(), o.date_added) AS days,
							o.date_added,
							o.order_id
						FROM
							".DB_PREFIX."order o
						WHERE
							o.order_status_id = 1
						ORDER BY
							o.date_added ASC
					) tmp
				WHERE
					tmp.days >= 7
		");


		$this->db->query("
			UPDATE
				" . DB_PREFIX . "order o
			SET 
				o.order_status_id=20
			WHERE
				o.order_id 
			IN 
			(
				SELECT
					order_id
				FROM
					(
						SELECT
							DATEDIFF(CURDATE(), o.date_added) AS days,
							o.date_added,
							o.order_id
						FROM
							".DB_PREFIX."order o
						WHERE
							o.order_status_id = 1
						ORDER BY
							o.date_added ASC
					) tmp
				WHERE
					tmp.days >= 7
			)
		");
	}

	public function check_pending(){
		$order_ids = $this->db->query("
			SELECT
				GROUP_CONCAT(order_id) as order_ids
			FROM
				(
					SELECT
						DATEDIFF(CURDATE(), o.date_added) AS days,
						o.date_added,
						o.order_id
					FROM
						".DB_PREFIX."order o
					WHERE
						o.order_status_id = 1
					ORDER BY
						o.date_added ASC
				) tmp
			WHERE
				tmp.days >= 7
		")->row;

		return $order_ids;
	}
}