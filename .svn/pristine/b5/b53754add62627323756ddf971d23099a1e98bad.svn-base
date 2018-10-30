<?php namespace YiZan\Services;
use YiZan\Models\StorageService;
use YiZan\Utils\Time;
use DB, Lang, Validator, App;

class StorageServiceService extends BaseService{
    public function getList($page , $pageSize){
        $page = $page ? $page : 1;
        $pageSize = $pageSize ? $pageSize : 20;
        $totalCount = StorageService::count();
        $data = StorageService::skip($page - 1)->take($pageSize)->get();
        $data = $data ? $data->toArray() : array();
        return ['list' => $data,'totalCount' => $totalCount];
    }

    public function getListById($id){
        $data = StorageService::where('id',$id)->get();
        return $data ? $data->toArray() : array();

    }
    public function delete($id){
        $result = [
            'code'  => 0,
            'data'  => null,
            'msg'   => ""
        ];
        StorageService::whereIn('id',$id)->delete();
        return $result;
    }
    public function save($id,$name,$url,$img){
        $result = array(
            'code'  => 0,
            'data'  => null,
            'msg' => null,
        );
        if($id && ($id > 0)){
            $msg = StorageService::where('id',$id)->get()->toArray();
            if(!$msg){
                $result['code'] = 1;
                $result['msg'] = '仓储公司不存在';
                return $result;
            }
            $storageService = StorageService::find($id);
        }else{
            if(StorageService::where('name',$name)->get()->toArray()){
                $result['code'] = 12345644;
                $result['msg'] = '仓储公司名称已经存在';  //添加成功
                return $result;
            }
            $storageService = new StorageService();
        }
        $storageService->name = $name;
        $storageService->url = $url;
        $storageService->img = $img;
        if(!$id && ($id > 0)){
            $storageService->create_time = Time::toTime(Time::toDate(time()));
        }
        $storageService->save();
        return $result;
    }
}