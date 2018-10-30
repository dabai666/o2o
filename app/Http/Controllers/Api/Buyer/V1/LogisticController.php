<?php
namespace YiZan\Http\Controllers\Api\Buyer;

use Lang, Validator;
use YiZan\Models\LogisticsCompany;

/**
 * 活动
 */
class LogisticController extends UserAuthController{
    public function getList(){
        if($this->request('id') > 0){
            $logistic = LogisticsCompany::where('id','=',$this->request('id'))->get()->toArray();
        }else{
            $logistic = LogisticsCompany::orderBy('id','asc')->get()->toArray();
        }
        return $this->outputData($logistic);
    }
}