<?php
namespace YiZan\Http\Controllers\Admin;

use YiZan\Models\Order;
use YiZan\Utils\Time;
use YiZan\Http\Requests\Admin\OrderCreatePostRequest;
use View, Input, Lang, Route, Page, Form, Format, Response, Cache;
/**
 * 订单管理
 */
class ServiceOrderController extends AuthController {
    /**
     * 订单列表
     */
    public function index() {
        $post = Input::all();
        $args = [
            'orderType' => 2,
            'sn' => trim($post['sn']),
            'mobile' => trim($post['mobile']),
            'beginTime' => trim($post['beginTime']) != '' ?  Time::toTime($post['beginTime']) : '',
            'endTime' => trim($post['endTime']) != '' ?  Time::toTime($post['endTime']) : '',
            'payStatus' => $post['payStatus'] != '-1' ?  $post['payStatus'] : '',
            'status' => (int)$post['status'] > 0 ?  $post['status'] : 0,
            'sellerName' => trim($post['sellerName']),
            'page' => (int)$post['page'],
            'payTypeStatus' => $post['payTypeStatus'],
        ];
        $result = $this->requestApi('order.lists', $args);
        if( $result['code'] == 0 ) {
            View::share('list', $result['data']['list']);
        }
        View::share('nav',$post['nav']);
        unset($args['page']);
        View::share('excel',http_build_query($args));
        View::share('args',$args);
        View::share('searchUrl', u('ServiceOrder/index',['status' => $post['status'], 'nav'=>$post['nav']]));
        return $this->display();
    }


    /*
	* 随机指派
	*/
    public function reassign() {
        $args = Input::all();
        $result = $this->requestApi('order.ranupdate', $args);
        return Response::json($result);
    }



    /**
     * 订单修改
     */
    public function refundRemark() {
        $post = Input::all();
        if( !empty($post['id']) ) {
            $args['id'] = intval($post['id']);
        }else{
            return $this->error(Lang::get('admin.code.23000'));
        }

        if( !empty($post['status']) ) {
            $args['status'] = $post['status'];
        }else{
            return $this->error(Lang::get('admin.code.23004'));
        }

        //退款需要添加备注
        if( $post['status'] == ORDER_STATUS_REFUND_HANDLE ){
            if( !empty($post['remark']) ) {
                $args['content'] = strval(trim($post['remark']));
            }else{
                return $this->error(Lang::get('admin.code.23001'));
            }
        }
        //拒绝需要添加备注
        if( $post['status'] == ORDER_STATUS_CANCEL_ADMIN ){
            if( !empty($post['refuseContent']) ) {
                $args['refuseContent'] = strval(trim($post['refuseContent']));
            }else{
                return $this->error(Lang::get('admin.code.50201'));
            }
        }
        $result = $this->requestApi('order.update',$args);

        if($result['code']>0) {
            return $this->error($result['msg']);
        }
        return $this->success(Lang::get('admin.code.98008'), u('Order/detail',['id'=>$args['id']]));
    }

    /**
     * 订单详细
     */
    public function detail() {
        $args = Input::all();
        $result = $this->requestApi('order.get', $args);
        View::share('data', $result['data']);
        return $this->display();
    }

    /**
     * 删除订单
     */
    public function destroy() {
        $args = Input::all();
        if( !empty( $args['id'] ) ) {
            $result = $this->requestApi('order.delete',$args);
        }
        if ( $result['code'] == 0 ) {
            return $this->success($result['msg']);
        } else {
            return $this->error($result['msg']);
        }

    }

    /**
     * 导出到excel
     */
    /**
     * 导出到excel
     */
    public function export() {
        require_once base_path().'/vendor/phpexcel/PHPExcel.php';
        $execl = new \PHPExcel();

        $execl->setActiveSheetIndex(0);
        $sheet = $execl->getActiveSheet();
        $sheet->setTitle('订单列表');

        $sheet->setCellValue('A1', "订单号");
        $sheet->setCellValue('B1', "下单时间");
        $sheet->setCellValue('C1', "订单状态");
        $sheet->setCellValue('D1', "支付状态");
        $sheet->setCellValue('E1', "会员名");
        $sheet->setCellValue('F1', "地址");
        $sheet->setCellValue('G1', "配送时间");
        $sheet->setCellValue('H1', "支付类型");
        $sheet->setCellValue('I1', "订单备注");
        $sheet->setCellValue('J1', "取消原因");
        $sheet->setCellValue('K1', "店铺名称");
        $sheet->setCellValue('L1', "使用积分");
        $sheet->setCellValue('M1', "总金额");
        $sheet->setCellValue('N1', "商品金额");
        $sheet->setCellValue('O1', "配送费");
        $sheet->setCellValue('P1', "优惠金额");
        $sheet->setCellValue('Q1', "积分抵扣金额");
        $sheet->setCellValue('R1', "首单立减");
        $sheet->setCellValue('S1', "特价优惠");
        $sheet->setCellValue('T1', "满减金额");
        $sheet->setCellValue('U1', "支付金额");
        $sheet->setCellValue('V1', "商家金额");
        $sheet->setCellValue('W1', "抽成金额");
        $sheet->setCellValue('X1', "支付方式");

        $sheet->getColumnDimension('A')->setWidth(25);
        $sheet->getColumnDimension('B')->setWidth(20);
        $sheet->getColumnDimension('C')->setWidth(15);
        $sheet->getColumnDimension('D')->setWidth(15);
        $sheet->getColumnDimension('E')->setWidth(20);
        $sheet->getColumnDimension('F')->setWidth(20);
        $sheet->getColumnDimension('G')->setWidth(15);
        $sheet->getColumnDimension('H')->setWidth(15);
        $sheet->getColumnDimension('I')->setWidth(30);
        $sheet->getColumnDimension('J')->setWidth(30);
        $sheet->getColumnDimension('K')->setWidth(20);
        $sheet->getColumnDimension('L')->setWidth(15);
        $sheet->getColumnDimension('M')->setWidth(15);
        $sheet->getColumnDimension('N')->setWidth(15);
        $sheet->getColumnDimension('O')->setWidth(15);
        $sheet->getColumnDimension('P')->setWidth(15);
        $sheet->getColumnDimension('Q')->setWidth(15);
        $sheet->getColumnDimension('R')->setWidth(15);
        $sheet->getColumnDimension('S')->setWidth(15);
        $sheet->getColumnDimension('T')->setWidth(15);
        $sheet->getColumnDimension('U')->setWidth(15);
        $sheet->getColumnDimension('V')->setWidth(15);
        $sheet->getColumnDimension('W')->setWidth(15);
        $sheet->getColumnDimension('X')->setWidth(15);

        $sheet->getStyle('B')->getAlignment()->setWrapText(true);

        $args = Input::all();
        $args['orderType'] = 2;
        $args['pageSize'] = 1000;
        $i = 2;
        $result = $this->requestApi('order.lists', $args);

        if($args['json'] == 1){
            if(empty($result['data']['list'])){
                $results['code'] = 0;
            }else{
                $results['code'] = 1;
            }
            die(json_encode($results));
        }

        $payStatus = [0 => '等待支付', 1 => '已支付'];
        foreach ($result['data']['list'] as $key => $value) {

            if($value['isCashOnDelivery']){
                $payStatusType = '货到付款';
            }
            else{
                if($value['payStatus'] == 1){
                    $payStatusType = '在线支付';
                }  
                else{
                    $payStatusType = '未支付';
                }
            }

            $sheet->setCellValue('A'.$i, "SN:".$value['sn']);
            $sheet->setCellValue('B'.$i, yztime($value['createTime']));
            $sheet->setCellValue('C'.$i, $value['orderStatus']);
            $sheet->setCellValue('D'.$i, $payStatus[$value['payStatus']]);
            $sheet->setCellValue('E'.$i, $value['user']['name']);
            $sheet->setCellValue('F'.$i, $value['address']);
            $sheet->setCellValue('G'.$i, yztime($value['freTime']));
            $sheet->setCellValue('H'.$i, $value['payType']);
            $sheet->setCellValue('I'.$i, $value['buyRemark']);
            $sheet->setCellValue('J'.$i, $value['cancelRemark']);
            $sheet->setCellValue('K'.$i, $value['seller']['name']);
            $sheet->setCellValue('L'.$i, $value['integral']);
            $sheet->setCellValue('M'.$i,$value['totalFee']);
            $sheet->setCellValue('N'.$i,$value['goodsFee']);
            $sheet->setCellValue('O'.$i,$value['freight']);
            $sheet->setCellValue('P'.$i,$value['discountFee']);
            $sheet->setCellValue('Q'.$i,$value['integralFee']);
            $sheet->setCellValue('R'.$i,$value['activityNewMoney']);
            $sheet->setCellValue('S'.$i,$value['activityGoodsMoney']);
            $sheet->setCellValue('T'.$i,$value['activityFullMoney']);
            $sheet->setCellValue('U'.$i,$value['payFee']);
            $sheet->setCellValue('V'.$i,$value['sellerFee']);
            $sheet->setCellValue('W'.$i,$value['drawnFee']);
            $sheet->setCellValue('X'.$i,$payStatusType);
            $i++;
        }

        $name = iconv("utf-8", "gb2312", "订单列表详细");
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
