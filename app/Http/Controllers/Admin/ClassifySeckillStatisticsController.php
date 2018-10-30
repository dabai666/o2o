<?php
namespace YiZan\Http\Controllers\Admin;

use Psy\Util\Json;
use YiZan\Models\OrderConfig;
use YiZan\Utils\Time;
use View, Input, Lang, Route, Page, Form;
class ClassifySeckillStatisticsController extends AuthController {
    public function index(){
        $args = Input::all();
        $currenYear = (int)Time::toDate(UTC_TIME, 'Y');
        $orderyear = array();
        for($i=10; $i >= 0; $i--){
            $orderyear[10-$i]['yearName'] = $currenYear - $i;
        }
        rsort($orderyear);
        View::share('orderyear',$orderyear);
        $args['year'] = ($args['year'] > 0) ? $args['year'] : (int)Time::toDate(UTC_TIME, 'Y');
        $args['month'] = ($args['month'] > 0) ? $args['month'] : (int)Time::toDate(UTC_TIME, 'm');
        View::share('args', $args);
        $result = $this->requestApi('classifyseckillstatistics.getList',$args);
        $activity = $this->requestApi('classifyseckillstatistics.getActivity');
        View::share('args',$args);
        View::share('activity',$activity);
        View::share('list',$result['data']['list']);
        View::share('totalCount', $result['data']['totalCount']);
        return $this->display();
    }
}