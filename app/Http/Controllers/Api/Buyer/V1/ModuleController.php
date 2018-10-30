<?php
namespace YiZan\Http\Controllers\Api\Buyer;

use YiZan\Models\IndexModel;
use Lang, Validator;

/**
 * 首页底部导航
 */
class ModuleController extends BaseController{
    public function getModule(){
        $page = 0;
        $pageSize = 4;
        $data = IndexModel::where('status','=',1)
             ->skip(($page - 1) * $pageSize)
             ->take($pageSize)
             ->orderBy('sort','asc')
             ->get()
             ->toArray();
        foreach ($data as $key => $val) {
            $url = '';
            switch ($val['type']) {
                case 1:
                    $url = (strstr($val['url'],'http://') || strstr($val['url'],'https://')) ? $val['url'] : 'https://'.$val['url'];
                    break;
                case 2:
                    $url = u('Logistic/index',['index_flage'=>'index']);
                    break;
                case 3:
                    $url = u('Activity/seckill',['index_flage'=>'index']);
                    break;
                case 4:
                    $url = u('Coupon/index',['index_flage'=>'index']);
                    break;
            }
            $data[$key]['url'] = $url;
        }
        return $this->outputData($data);
    }
}