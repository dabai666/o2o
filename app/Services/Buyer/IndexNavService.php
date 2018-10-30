<?php 
namespace YiZan\Services\Buyer;

use YiZan\Models\IndexNav; 
/**
 * 首页底部导航管理
 */
class IndexNavService extends \YiZan\Services\IndexNavService {
	
	/**
	 * 获取状态为1的所有导航
	 */ 
	public static function getLists($onlySystem, $cityId){
		if($onlySystem){
			//只取系统导航菜单
			$list = IndexNav::where('city_id', 0)
							->where('status', 1)
							->orderBy('sort', 'ASC')
							->take(5)
							->get()
							->toArray();
		} else {  
			$list = IndexNav::whereRaw("((city_id = {$cityId}) or (city_id = 0))")
							->where('status', 1)
						 	->take(5)
						 	->orderBy('sort', 'ASC')
						 	->get()
						 	->toArray(); 
		} 
		return $list;
	}

}
