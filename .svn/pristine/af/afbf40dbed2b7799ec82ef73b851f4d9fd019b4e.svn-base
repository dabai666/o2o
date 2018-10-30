<?php namespace YiZan\Services;
use YiZan\Models\LogisticsCompany;
use YiZan\Utils\Time;
use DB, Lang, Validator, App;

class LogisticsCompanyService extends BaseService{
    public function getList($page,$pageSize){
        $page = $page ? $page : 1;
        $pageSize = $pageSize ? $pageSize : 20;
        $totalCount = LogisticsCompany::count();
        $data = LogisticsCompany::skip($page - 1)->take($pageSize)->get();
        $data = $data ? $data->toArray() : array();
        return ['list' => $data,'totalCount'=>$totalCount];
    }
    public function getListById($id){
        $data = LogisticsCompany::where('id',$id)->get();
        return $data ? $data->toArray() : array();
    }
    public function delete($id){
        $result = [
            'code'  => 0,
            'data'  => null,
            'msg'   => ""
        ];
        LogisticsCompany::whereIn('id',$id)->delete();
        return $result;
    }
    public function save($id,$name,$logo,$aging,$tel,$qq,$introduction,$contacts){
        $result = array(
            'code'  => 0,
            'data'  => null,
            'msg' => null,
        );
        if($id && ($id > 0)){
            $msg = LogisticsCompany::where('id',$id)->get()->toArray();
            if(!$msg){
                $result['code'] = 1;
                $result['msg'] = '公司物流不存在';  //添加成功
                return $result;
            }
//            if($msg[0]['name'] == $name){
//                $result['code'] = 2;
//                $result['msg'] = '公司物流名称已经存在';  //添加成功
//                return $result;
//            }
            $tag = LogisticsCompany::find($id);
        }else{
            if(LogisticsCompany::where('name',$name)->get()->toArray()){
                $result['code'] = 12345644;
                $result['msg'] = '公司物流名称已经存在';  //添加成功
                return $result;
            }
            $tag = new LogisticsCompany();
        }
        $tag->name = $name;
        $tag->logo = $logo;
        $tag->aging = $aging;
        $tag->tel = $tel;
        $tag->qq = $qq;
        $tag->introduction = $introduction;
        $tag->contacts = $contacts;
        if($id && ($id > 0)){

        }else{
            $tag->create_time = Time::toTime(Time::toDate(time()));
        }
        $tag->save();
        return $result;
    }
}