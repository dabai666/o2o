<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/14
 * Time: 14:57
 */
namespace YiZan\Services;
use YiZan\Utils\String;
use YiZan\Utils\Time;
use DB, Validator;
use YiZan\Models\Module;
/**
 * 模块管理
 */
class ModuleService extends BaseService
{
    /**
     * 模块列表
     */
    public static function getList(){
        $list = Module::orderBy('id', 'desc');
            $totalCount = $list->count();
            $list = $list->get()->toArray();
        return ["list"=>$list, "totalCount"=>$totalCount];
    }

    public function create($name,$image,$type,$sort,$status,$produce){

        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'name' => ['required'],
            'image' => ['required'],
        );

        $messages = array(
            'name.required' => 70103,    // 请填写名称
            'image.required' => 70104,//请上传图片
        );

        $validator = Validator::make(
            [
                'name' => $name,
                'image' => $image,

            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();

            return $result;
        }

        $module = new Module();
        $module->name       = $name;
        $module->image        = $image;
        $module->type          = $type;
        $module->sort         = $sort;
        $module->status      = $status;
        $module->type          = $type;
        $module->create_time   = Time::getTime();
        $module->produce = $produce;
        $res = $module->save();
        return $result;
    }
    public function update($id,$name,$image,$type,$sort,$status,$produce){
        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'name' => ['required'],
            'image' => ['required'],
        );

        $messages = array(
            'name.required' => 70103,    // 请填写名称
            'image.required' => 70104,//请上传图片
        );

        $validator = Validator::make(
            [
                'name' => $name,
                'image' => $image,

            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();

            return $result;
        }

        Module::where("id", $id)->update(array(
            'name'        => $name,
            'image'    => $image,
            'type'           => $type,
            'sort'          => $sort,
            'status'       => $status,
            'produce'      => $produce
        ));
        return $result;
    }
    public static function getById($id){
    return Module::where('id', $id)
        ->first();
    }

    public static function delete($id)
    {
        $result = [
            'code'	=> 0,
            'data'	=> null,
            'msg'	=> ""
        ];

        if(!is_array($id)){
            $id = [$id];
        }

        Module::whereIn('id', $id)->delete();
        return $result;
    }

    public static function getInfo($type){
        return Module::where('type', $type)
            ->first();
    }

    public function FinanceSupermarkCreate($url){

        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'url' => ['required'],
        );

        $messages = array(
            'url.required' => 70103,    // url不能为空
        );

        $validator = Validator::make(
            [
                'url' => $url
            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();

            return $result;
        }

        $module = new Module();
        $module->url       = $url;
        $module->type      =1;
        $module->create_time = Time::getTime();
        $res = $module->save();
        return $res;
    }

    public function FinanceSupermarkUpdate($id,$url){

        $result = array(
            'code' => self::SUCCESS,
            'data' => null,
            'msg' => ''
        );

        $rules = array(
            'url' => ['required'],
        );

        $messages = array(
            'url.required' => 70103,    // url不能为空
        );

        $validator = Validator::make(
            [
                'url' => $url
            ], $rules, $messages);
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();

            return $result;
        }

        Module::where("id", $id)->update(array(
            'url'        => $url
        ));
    }

}