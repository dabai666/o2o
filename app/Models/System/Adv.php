<?php 
namespace YiZan\Models\System;

class Adv extends \YiZan\Models\Adv 
{
	protected $visible = ['id', 'name', 'image', 'bg_color', 'type', 'arg', 'app',
        'sort', 'status', 'city', 'position','create_time','city_id', 'seller_cate_id',
        'flage','image1','type1','arg1','image2','type2','arg2','image3','type3','arg3','image4','type4','arg4','title2','instruction2','instruction2_bg','title3','instruction3','instruction3_bg','title4','instruction4','instruction4_bg','adv_serialize','sign2','sign3','sign4','mark2','mark3','mark4','remarks2','remarks3','remarks4'];
    
    public function city()
    {
        return $this->belongsTo('YiZan\Models\Region', 'city_id', 'id');
    }
    
    public function position()
    {
        return $this->belongsTo('YiZan\Models\AdvPosition', 'position_id', 'id');
    }
}
