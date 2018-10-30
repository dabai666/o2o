<?php 
namespace YiZan\Services;

use YiZan\Models\UserTag;
use YiZan\Utils\Time;
use Lang, Validator,DB;

/**
 * 会员标签
 */
class UserTagService extends BaseService
{

	/**
	 * [getList 获取标签分类内列表]
	 * @param  [type] $page     [分页]
	 * @param  [type] $pageSize [分页大小]
	 * @return [type]           [description]
	 */
	public static function getList($status,$name = "") {

        $list = UserTag::orderBy('sort','asc')->orderBy('id', 'desc');
        if(!empty($status))
        {
            $list = $list->where('status', $status);
        }
        if(!empty($name))
        {
            $list = $list->where('name','like', '%'.$name.'%');
        }
        $list = $list->get()->toArray();

        return $list;
	}

   /**
     * [save ]
     * @param  [type] $id   [编号]
     * @param  [type] $name [分类名称]
     * @param  [type] $sort  [排序]
     * @param  [type] $status  [状态]
     * @return [type]           [description]
     */
    public static function save($id, $name, $sort, $status)
    {
        $result = array(
            'code'  => 0,
            'data'  => null,
            'msg' => null,
        );

        $rules = array(
            'name'          => ['required'],
            'sort'          => ['required']
        );
        
        $messages = array (
            'name.required'     => 31000,   // 请填写分类名称
            'sort.required'     => 31001,   // 请输入排序
        );

        $validator = Validator::make([
                'name'          => $name,
                'sort'          => $sort,
            ], $rules, $messages);
        
        //验证信息
        if ($validator->fails()) {
            $messages = $validator->messages();
            $result['code'] = $messages->first();
            return $result;
        }

        if($id > 0){
        	$tag = UserTag::find($id);
        	$result['msg'] = Lang::get('api.success.update_info'); //更新成功
        }else{
        	$tag = new UserTag();
            $result['msg'] = Lang::get('api.success.add');  //添加成功
        }

        $tag->name = $name;
        $tag->sort = $sort;
        $tag->status = $status;
        $tag->create_time = UTC_TIME;
        $tag->save();

        return $result;

    } 

    /**
     * [get 获取单个分类]
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public static function get($id) {
    	return UserTag::find($id);
    }


    public static function delete($id) 
    {
        $result = [
            'code'  => 0,
            'data'  => null,
            'msg'   => ""
        ];
        UserTag::whereIn('id', $id)->delete(); 
        return $result;
    }

}
