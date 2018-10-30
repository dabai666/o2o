<?php 
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Models\SystemTag;
use YiZan\Models\SystemTagList;
use YiZan\Services\SystemTagService;
use YiZan\Utils\Time;

class SystemTagController extends BaseController {

	//获取标签分类
	public function getSystemTag(){
		$data = SystemTag::where('status',1)->with('systemTagList')->orderBy('sort', 'asc')->get()->toArray();
		foreach($data as $k =>$v){
			$pid = array();
			if($v['systemTagList']){
				foreach($v['systemTagList'] as $kk => $vv){
					if(!in_array($vv['pid'],$pid)){
						$pid[] = $vv['pid'];
					}
				}
				 $secondLevel = SystemTagList::whereIn('id',$pid)->where('status',1)->get()->toArray();
				$data[$k]['systemTagList'] = $secondLevel;
			}
			/*else{
				unset($data[$k]);
			}*/
		}
		return $this->outputData($data);
	}

	/**
	 * [lists 获取标签分类列表]
	 * @return [type] [description]
	 */
	public function lists() {
        $data = SystemTagService::getList(
            $this->request('status'),
            $this->request('name')
        );
        return $this->outputData($data);
    }


    /**
     *  创建商品标签分类
     */
    public function save() {
        $result = SystemTagService::save(
        	intval($this->request('id')),
            strval($this->request('name')),
            intval($this->request('sort')),
            intval($this->request('status'))
        );
        return $this->output($result);
    }

    /**
     * [get 获取单个分类信息]
     * @return [type] [description]
     */
    public function get() {
    	 $result = SystemTagService::get(
        	intval($this->request('id'))
        );
        return $this->output($result);
    }

    /**
     * 分类信息删除
     */
    public function delete() {
        $result = SystemTagService::delete(
            $this->request('id')
        );
        return $this->output($result);
    }


}