<?php namespace YiZan\Http\Controllers\Wap;
use YiZan\Services\PaymentService;
/**
 * 首页
 */
class TestController extends BaseController {

    //
    public function index() {
        $atest = PaymentService::getAtest();
		var_dump($atest);
    }

}
