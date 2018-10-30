<?php
namespace YiZan\Http\Controllers\Admin;

use Psy\Util\Json;
use YiZan\Models\OrderConfig;
use YiZan\Utils\Time;
use View, Input, Lang, Route, Page, Form;
/**
 * 订单统计
 */
class ClassifyBusinessStatisticsController  extends AuthController {
    public function index(){
        $args = Input::all();
        $currenYear = (int)Time::toDate(UTC_TIME, 'Y');
        $orderyear = array();
        for($i=10; $i >= 0; $i--){
            $orderyear[10-$i]['yearName'] = $currenYear - $i;
        }
        rsort($orderyear);
//        $orderyear = $this->requestApi('seller.statistics.year',['sellerId'=>ONESELF_SELLER_ID]);
        View::share('orderyear',$orderyear);
        $args['year'] = ($args['year'] > 0) ? $args['year'] : (int)Time::toDate(UTC_TIME, 'Y');
        $args['month'] = ($args['month'] > 0) ? $args['month'] : (int)Time::toDate(UTC_TIME, 'm');
        View::share('args', $args);
        $result = $this->requestApi('goods.cate.getClassifyList',$args);
//        var_dump($result);die;
        View::share('list',$result);
        $result = $this->requestApi('SystemTagList.getTagListFirst');
        $tagList1 = [
            'id' => 0,
            'name' => '全部'
        ];
        array_unshift($result['data'],$tagList1);
        View::share('cate1', $result['data']);
        if(!$args['secondId']){
            $cate2 = array(array());
        }else{
            $res = $this->requestApi('SystemTagList.getTagListByPid',['pid'=>$args['firstId']]);
            $cate2 = $res['data'];
        }
        array_unshift($cate2,$tagList1);
        if(!$args['secondId']){
            unset($cate2[1]);
        }
        View::share('cate2', $cate2);
        return $this->display();
    }
    public function getTagListByPid(){
        $args = Input::all();
        $result = $this->requestApi('SystemTagList.getTagListByPid',$args);
        $tagList1 = [
            'id' => 0,
            'name' => '全部'
        ];
        array_unshift($result['data'],$tagList1);
        echo Json::encode($result['data']);
    }
    public function detail(){
        $args = Input::all();
        $currenYear = (int)Time::toDate(UTC_TIME, 'Y');
        $orderyear = array();
        for($i=10; $i >= 0; $i--){
            $orderyear[10-$i]['yearName'] = $currenYear - $i;
        }
        rsort($orderyear);
        $args['year'] = ($args['year'] > 0) ? $args['year'] : (int)Time::toDate(UTC_TIME, 'Y');
        $args['month'] = ($args['month'] > 0) ? $args['month'] : (int)Time::toDate(UTC_TIME, 'm');
        $result = $this->requestApi('goods.cate.getClassifyListDetail',$args);
        View::share('lists',$result['data']['list']);
        View::share('args',$args);
        View::share('orderyear',$orderyear);
        View::share('totalCount', $result['data']['totalCount']);
        return $this->display();
    }

    public function index1(){
        $args = Input::all();
        $orderyear = $this->requestApi('seller.statistics.year',['sellerId'=>ONESELF_SELLER_ID]);
        View::share('orderyear',$orderyear['data']);
        $args['year'] = ($args['year'] > 0) ? $args['year'] : (int)Time::toDate(UTC_TIME, 'Y');
        $args['month'] = ($args['month'] > 0) ? $args['month'] : (int)Time::toDate(UTC_TIME, 'm');
        View::share('args', $args);
        $result = $this->requestApi('goods.cate.getCateList',$args);
        View::share('list',$result);
        $argsp['sellerId'] = ONESELF_SELLER_ID;
        $result = $this->requestApi('goods.cate.lists',$argsp );
        $tagList2 = [
            "id" => 0,
            "name" => "全部",
        ];
        array_unshift($result['data'],$tagList2);
        View::share('cate', $result['data']);
        return $this->display();
    }

    /**
     * 导出到excel
     */
    public function export() {
        require_once base_path().'/vendor/phpexcel/PHPExcel.php';
        $execl = new \PHPExcel();

        $execl->setActiveSheetIndex(0);
        $sheet = $execl->getActiveSheet();
        $sheet->setTitle(' 商城分类统计');

        $sheet->setCellValue('A1', "二级标签");
        $sheet->setCellValue('B1', "商品名称");
        $sheet->setCellValue('C1', "分类名称");
        $sheet->setCellValue('D1', "商品品牌");
        $sheet->setCellValue('E1', "销售份数");
        $sheet->setCellValue('F1', "销售额");
        $sheet->setCellValue('G1','销售重量（kg）');

        $sheet->getColumnDimension('A')->setWidth(30);
        $sheet->getColumnDimension('B')->setWidth(30);
        $sheet->getColumnDimension('C')->setWidth(15);
        $sheet->getColumnDimension('D')->setWidth(13);
        $sheet->getColumnDimension('E')->setWidth(30);
        $sheet->getColumnDimension('F')->setWidth(30);
        $sheet->getColumnDimension('G')->setWidth(30);

        $sheet->getStyle('B')->getAlignment()->setWrapText(true);

        $args = Input::all();
        $args['year'] = ($args['year'] > 0) ? $args['year'] : (int)Time::toDate(UTC_TIME, 'Y');
        $args['month'] = ($args['month'] > 0) ? $args['month'] : (int)Time::toDate(UTC_TIME, 'm');
        View::share('args', $args);
        $result = $this->requestApi('goods.cate.getClassifyListDetail',$args);
        $result = $result['data']['list'];
//        $result = $this->requestApi('order.ordercount.revenue',$args);
//        $sheet->setCellValue('A2', "汇总");
//        $sheet->setCellValue('B2', $result['data']['total']['totalMoney']);
//        $sheet->setCellValue('C2', $result['data']['total']['totalNum']);
//        $sheet->setCellValue('D2', $result['data']['total']['totalCancelNum']);
//        $sheet->setCellValue('E2', $result['data']['total']['totalPromotion']);
//        $sheet->setCellValue('F2', $result['data']['total']['totalIntegral']);
        $i = 2;
        foreach ($result as $key => $value) {
            $sheet->setCellValue('A'.$i, $value['tagListName']);
            $sheet->setCellValue('B'.$i, $value['goodsName']);
            $sheet->setCellValue('C'.$i, $value['name']);
            $sheet->setCellValue('D'.$i, $value['shopName']);
            $sheet->setCellValue('E'.$i, $value['totalNum']);
            $sheet->setCellValue('F'.$i, $value['totalPrice']);
            $sheet->setCellValue('G'.$i, $value['totalWeight']);
            $i++;
        }

        $name = iconv("utf-8", "gb2312", "商城分类统计");
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$name.'.xlsx"');
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
        header ('Cache-Control: cache, must-revalidate');
        header ('Pragma: public');
        header("Expires: 0");
        $execl = \PHPExcel_IOFactory::createWriter($execl, 'Excel2007');
        $execl->save('php://output');
    }
}
