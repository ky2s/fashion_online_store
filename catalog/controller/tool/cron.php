<?php
class ControllerToolCron extends Controller {
	public function updatePendingOrder() {
		$this->load->model('tool/cron');
		$this->model_tool_cron->updatePending();
	}
}