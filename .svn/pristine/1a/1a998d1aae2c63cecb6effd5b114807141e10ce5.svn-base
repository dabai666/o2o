<?php namespace YiZan\Http\Controllers\Wap;

use YiZan\Utils\Time;
use View, Input, Lang, Route, Page , Session, Response;
/**
 * 位置选取（小区）
 */
class LogisticController extends UserAuthController {
    public function index(){
        $argc = Input::all();
        $result = $this->requestApi('Logistic.getList',$argc);
        $storage = $this->requestApi('StorageService.getList',$argc);
        View::share('storageService',$storage['data']['list']);
        if($argc['index_flage']){
            View::share('nav_back_url', u('Index/index'));
        }
        View::share('data',$result['data']);
        if($argc['id'] > 0){
            return $this->display('detail');
        }else{
            return $this->display();
        }
    }
    public function detail(){
        $argc = Input::all();
        $result = $this->requestApi('StorageService.getListById',$argc);
        View::share('list',$result['data']);
        return $this->display();
    }
    public function indexList(){
        $argc = Input::all();
        $storage = $this->requestApi('StorageService.getList',$argc);
        View::share('storageService',$storage['data']['list']);
        return $this->display('lists_item');
    }
      /**
     * 字符串截取
     * @param unknown $str
     * @param unknown $length
     * @param string $end_with
     * @return unknown|string
     */
    protected function  utf8_substr_ifneed($str, $length, $end_with = '…'){
        if (strlen($str) <= $length)
            return $str;

        //正则
        $re_utf8 = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";

        preg_match_all($re_utf8, $str, $match);

        $new_str = "";
        $now_length = 0;
        $max_length = $length - (strlen($end_with) - 1);
        foreach ($match[0] as $char) {
            $now_length += (strlen($char) > 1) ? 2 : 1;//英文字符长度，汉字算两个
            if ($now_length > $max_length) break;

            $new_str .= $char;
        }

        return $new_str . $end_with;
    }
}